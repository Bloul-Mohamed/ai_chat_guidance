import 'package:ai_chat_guidance/core/shared/providers/connection_state_provider.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/empty_state_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/logout_button_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/menu_button_widget.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/offline_mode_animation_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  void _onSuggestionTap(String suggestion) {
    setState(() {
      _messageController.text = suggestion.replaceAll('\n', ' ');
      _sendMessage();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  // Back Button
                  MenuButtonWidget(),
                  LogoutButtonWidget(),

                  // Menu Button
                ],
              ),
            ),

            // Internet Status Banner
            OfflineModeAnimationScreen(),
            SizedBox(height: 8.h),

            // Content
            Expanded(
              child: _messages.isEmpty
                  ? EmptyStateWidget(onSuggestionTap: _onSuggestionTap)
                  : _buildMessagesList(),
            ),

            // Message Input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorsManager.blueColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _messages[index],
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
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
                    enabled: isOnline,
                    style: TextStyle(
                      color: isOnline
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      fontSize: 15.sp,
                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: isOnline
                          ? context.tr('send_message')
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
                    onSubmitted: isOnline ? (_) => _sendMessage() : null,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: isOnline
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFF2A2A2A).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    LucideIcons.send,
                    color: isOnline
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 20.w,
                  ),
                  onPressed: isOnline ? _sendMessage : null,
                ),
              ),
            ],
          );
        },
        loading: () => Row(
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
        ),
        error: (err, stack) => Row(
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
        ),
      ),
    );
  }
}
