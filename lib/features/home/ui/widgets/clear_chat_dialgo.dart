import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_chat_guidance/features/home/data/providers/chat_provider.dart';

void showClearChatDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          context.tr('clear_chat'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.tr('clear_chat_confirmation'),
          style: TextStyle(color: const Color(0xFF9E9E9E), fontSize: 15.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              context.tr('cancel'),
              style: TextStyle(color: const Color(0xFF9E9E9E), fontSize: 15.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(clearChatProvider)();
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              context.tr('clear'),
              style: TextStyle(
                color: Colors.red,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
