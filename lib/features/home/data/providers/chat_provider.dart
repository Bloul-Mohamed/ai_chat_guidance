import 'package:ai_chat_guidance/features/home/data/models/message_chat_model.dart';
import 'package:ai_chat_guidance/core/services/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Gemini Service Provider
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

// Chat Messages State Provider
final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<MessageChatModel>>((ref) {
      return ChatMessagesNotifier();
    });

// Chat Messages Notifier
class ChatMessagesNotifier extends StateNotifier<List<MessageChatModel>> {
  ChatMessagesNotifier() : super([]);

  void addMessage(MessageChatModel message) {
    state = [...state, message];
  }

  void clearMessages() {
    state = [];
  }

  void updateLastMessage(String newMessage) {
    if (state.isEmpty) return;

    final updatedMessages = [...state];
    final lastIndex = updatedMessages.length - 1;
    updatedMessages[lastIndex] = MessageChatModel(
      id: updatedMessages[lastIndex].id,
      message: newMessage,
      fromAI: updatedMessages[lastIndex].fromAI,
    );
    state = updatedMessages;
  }

  void removeLastMessage() {
    if (state.isEmpty) return;
    state = state.sublist(0, state.length - 1);
  }
}

// Loading State Provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Initialization State Provider
final chatInitializationProvider = FutureProvider<void>((ref) async {
  final geminiService = ref.read(geminiServiceProvider);
  await geminiService.initializeChatWithPDF();
});

// Send Message Provider
final sendMessageProvider = Provider<Future<void> Function(String)>((ref) {
  return (String message) async {
    final geminiService = ref.read(geminiServiceProvider);
    final chatNotifier = ref.read(chatMessagesProvider.notifier);
    final loadingNotifier = ref.read(isLoadingProvider.notifier);

    if (message.trim().isEmpty) return;

    // Add user message
    final userMessage = MessageChatModel(
      message: message.trim(),
      fromAI: false,
    );
    chatNotifier.addMessage(userMessage);

    // Set loading state
    loadingNotifier.state = true;

    // Add temporary AI message
    final tempAIMessage = MessageChatModel(
      message: '...',
      fromAI: true,
    );
    chatNotifier.addMessage(tempAIMessage);

    try {
      // Ensure chat is initialized
      if (!geminiService.isInitialized) {
        await geminiService.initializeChatWithPDF();
      }

      // Get AI response
      final response = await geminiService.sendMessage(message.trim());

      // Update AI message with response
      chatNotifier.updateLastMessage(response);
    } catch (e) {
      // Determine error message based on user's language
      String errorMessage;
      if (_isArabic(message)) {
        errorMessage =
            'عذراً، حدث خطأ أثناء معالجة رسالتك. يرجى المحاولة مرة أخرى.\n\nالخطأ: ${e.toString()}';
      } else if (_isFrench(message)) {
        errorMessage =
            'Désolé, une erreur s\'est produite lors du traitement de votre message. Veuillez réessayer.\n\nErreur: ${e.toString()}';
      } else {
        errorMessage =
            'Sorry, an error occurred while processing your message. Please try again.\n\nError: ${e.toString()}';
      }

      // Update with error message
      chatNotifier.updateLastMessage(errorMessage);
    } finally {
      loadingNotifier.state = false;
    }
  };
});

// Helper functions
bool _isArabic(String text) {
  final arabicPattern = RegExp(r'[\u0600-\u06FF]');
  return arabicPattern.hasMatch(text);
}

bool _isFrench(String text) {
  final frenchWords = [
    'le',
    'la',
    'les',
    'un',
    'une',
    'est',
    'sont',
    'merci',
    'bonjour',
    'comment',
    'quoi',
    'où',
  ];
  final lowerText = text.toLowerCase();
  return frenchWords.any((word) => lowerText.contains(word));
}

// Clear Chat Provider
final clearChatProvider = Provider<void Function()>((ref) {
  return () {
    final chatNotifier = ref.read(chatMessagesProvider.notifier);
    final geminiService = ref.read(geminiServiceProvider);

    chatNotifier.clearMessages();
    geminiService.resetChat();
  };
});
