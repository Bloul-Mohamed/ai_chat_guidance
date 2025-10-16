import 'dart:typed_data';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/services.dart';

class GeminiService {
  late final GenerativeModel _model;
  ChatSession? _chat;
  bool _isInitialized = false;
  Uint8List? _pdfBytes;

  GeminiService() {
    _initializeModel();
  }

  void _initializeModel() {
    // Initialize the Gemini model using Firebase AI with Vertex AI backend
    final ai = FirebaseAI.googleAI();

    _model = ai.generativeModel(
      model: 'gemini-2.5-flash',
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 2048,
      ),
      systemInstruction: Content.system('''
أنت مساعد جامعي مفيد لجامعة عمار الثليجي في الأغواط، الجزائر.
لديك إمكانية الوصول إلى دليل طالب شامل يحتوي على معلومات حول:
- أنظمة الجامعة (LMD و ING)
- الإجراءات الأكاديمية واللوائح
- خدمات الطلاب (المكتبة، النقل، المطعم)
- جداول الامتحانات وأنظمة التقييم
- التسجيل والإجراءات الإدارية

You are a helpful university assistant for Amar Telidji University in Laghouat, Algeria.
You have access to a comprehensive student guide that contains information about:
- University systems (LMD and ING)
- Academic procedures and regulations
- Student services (library, transport, cafeteria)
- Exam schedules and grading systems
- Registration and administrative processes

Vous êtes un assistant universitaire utile pour l'Université Amar Telidji à Laghouat, Algérie.
Vous avez accès à un guide étudiant complet qui contient des informations sur:
- Les systèmes universitaires (LMD et ING)
- Les procédures académiques et les règlements
- Les services étudiants (bibliothèque, transport, cafétéria)
- Les horaires d'examens et les systèmes de notation
- L'inscription et les procédures administratives

IMPORTANT: Always respond in the SAME language the user asks their question in:
- If user writes in Arabic (العربية), respond in Arabic
- If user writes in English, respond in English  
- If user writes in French (Français), respond in French

Be friendly, clear, and helpful. Use the PDF document to provide accurate information.
'''),
    );
  }

  Future<void> initializeChatWithPDF() async {
    if (_isInitialized) return;

    try {
      // Load PDF from assets
      final pdfData = await rootBundle.load('assets/files/univ_data_file.pdf');
      _pdfBytes = pdfData.buffer.asUint8List();

      // Start chat with PDF in initial history using Content.multi
      _chat = _model.startChat(
        history: [
          Content('user', [
            InlineDataPart('application/pdf', _pdfBytes!),
            TextPart(
              '''هذا هو دليل الطالب الجامعي. يرجى استخدام هذه المعلومات للإجابة على أسئلة الطلاب.
            
This is the university student guide. Please use this information to answer student questions.

Ceci est le guide de l'étudiant universitaire. Veuillez utiliser ces informations pour répondre aux questions des étudiants.''',
            ),
          ]),
        ],
      );

      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize chat with PDF: $e');
    }
  }

  Future<String> sendMessage(String message) async {
    if (!_isInitialized) {
      await initializeChatWithPDF();
    }

    if (_chat == null) {
      throw Exception('Chat session not initialized');
    }

    try {
      final response = await _chat!.sendMessage(Content.text(message));

      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        return _getDefaultErrorMessage(message);
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  String _getDefaultErrorMessage(String userMessage) {
    // Detect language and return appropriate error message
    if (_isArabic(userMessage)) {
      return 'عذراً، لم أتمكن من الحصول على إجابة. يرجى المحاولة مرة أخرى.';
    } else if (_isFrench(userMessage)) {
      return 'Désolé, je n\'ai pas pu obtenir de réponse. Veuillez réessayer.';
    } else {
      return 'Sorry, I couldn\'t get a response. Please try again.';
    }
  }

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
    ];
    final lowerText = text.toLowerCase();
    return frenchWords.any((word) => lowerText.contains(word));
  }

  void resetChat() {
    _isInitialized = false;
    _chat = null;
    _pdfBytes = null;
  }

  bool get isInitialized => _isInitialized;
}
