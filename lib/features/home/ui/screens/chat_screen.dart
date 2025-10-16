import 'package:ai_chat_guidance/core/shared/providers/connection_state_provider.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/home/data/models/message_chat_model.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/empty_state_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/logout_button_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/menu_button_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/offline_mode_animation_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_chat_guidance/features/home/data/providers/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize chat with PDF when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FIXED: Use chatInitializationProvider instead of non-existent initializeChatProvider
      ref.read(chatInitializationProvider);
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = _messageController.text.trim();
    _messageController.clear();

    // Send message using provider
    await ref.read(sendMessageProvider)(message);

    // Scroll to bottom
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        // FIXED: Added safety check in case widget is disposed
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _onSuggestionTap(String suggestion) {
    _messageController.text = suggestion.replaceAll('\n', ' ');
    _sendMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final isLoading = ref.watch(isLoadingProvider);

    // FIXED: Listen to initialization state to handle errors
    final initializationState = ref.watch(chatInitializationProvider);

    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MenuButtonWidget(),
                  const LogoutButtonWidget(),
                ],
              ),
            ),

            // Internet Status Banner
            const OfflineModeAnimationScreen(),
            SizedBox(height: 8.h),

            // FIXED: Show initialization error if any
            initializationState.when(
              data: (_) => const SizedBox.shrink(),
              loading: () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        context.tr('initializing_chat'),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, stack) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.alertCircle,
                        color: Colors.red,
                        size: 16.w,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Initialization error: ${error.toString()}',
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (initializationState.hasError || initializationState.isLoading)
              SizedBox(height: 8.h),

            // Content
            Expanded(
              child: messages.isEmpty
                  ? EmptyStateWidget(onSuggestionTap: _onSuggestionTap)
                  : _buildMessagesList(messages),
            ),

            // Message Input
            _buildMessageInput(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList(List<MessageChatModel> messages) {
    // FIXED: Add listener to auto-scroll when new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(MessageChatModel message) {
    final isAI = message.fromAI;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: isAI
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAI) ...[
            // AI Avatar
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: ColorsManager.blueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                LucideIcons.brainCircuit,
                color: ColorsManager.blueColor,
                size: 18.w,
              ),
            ),
            SizedBox(width: 12.w),
          ],

          // Message Bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isAI
                    ? const Color(0xFF2A2A2A)
                    : ColorsManager.blueColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: message.message == '...'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          context.tr('thinking'),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      message.message,
                      style: GoogleFonts.cairo(
                        color:  Colors.white ,
                        fontSize: 15.sp,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.start,
                    ),
            ),
          ),

          if (!isAI) ...[
            SizedBox(width: 12.w),
            // User Avatar
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: ColorsManager.blueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                LucideIcons.user,
                color: ColorsManager.blueColor,
                size: 18.w,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isLoading) {
    final internetStatus = ref.watch(internetProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.background,
        border: Border(
          top: BorderSide(color: const Color(0xFF2A2A2A), width: 1),
        ),
      ),
      child: internetStatus.when(
        data: (isOnline) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _messageController,
                    enabled: isOnline && !isLoading,
                    style: TextStyle(
                      color: (isOnline && !isLoading)
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      fontSize: 15.sp,
                    ),
                    maxLines: null,
                    textInputAction:
                        TextInputAction.send, // FIXED: Added for better UX
                    decoration: InputDecoration(
                      hintText: isOnline
                          ? (isLoading
                                ? context.tr('processing')
                                : context.tr('send_message'))
                          : context.tr('no_internet_connection'),
                      hintStyle: TextStyle(
                        color: const Color(0xFF6B6B6B),
                        fontSize: 15.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                    ),
                    onSubmitted: (isOnline && !isLoading)
                        ? (_) => _sendMessage()
                        : null,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: (isOnline && !isLoading)
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFF2A2A2A).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.5),
                            ),
                          ),
                        )
                      : Icon(
                          LucideIcons.send,
                          color: (isOnline && !isLoading)
                              ? Colors.white
                              : Colors.white.withOpacity(0.3),
                          size: 20.w,
                        ),
                  onPressed: (isOnline && !isLoading) ? _sendMessage : null,
                ),
              ),
            ],
          );
        },
        loading: () => _buildLoadingInput(),
        error: (err, stack) => _buildErrorInput(),
      ),
    );
  }

  Widget _buildLoadingInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              enabled: false,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Checking connection...',
                hintStyle: TextStyle(
                  color: const Color(0xFF6B6B6B),
                  fontSize: 15.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              enabled: false,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Connection error',
                hintStyle: TextStyle(
                  color: const Color(0xFF6B6B6B),
                  fontSize: 15.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              LucideIcons.send,
              color: Colors.white.withOpacity(0.3),
              size: 20.w,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
