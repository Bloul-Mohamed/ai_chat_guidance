import 'package:ai_chat_guidance/core/shared/providers/connection_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionCardText extends ConsumerStatefulWidget {
  const SuggestionCardText({
    super.key,
    required this.text,
    required this.onSuggestionTap,
  });
  final String text;
  final void Function(String) onSuggestionTap;

  @override
  ConsumerState<SuggestionCardText> createState() => _SuggestionCardTextState();
}

class _SuggestionCardTextState extends ConsumerState<SuggestionCardText> {
  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(internetProvider);
    final isOnline = internetStatus.value ?? false;

    return InkWell(
      onTap: isOnline ? () => widget.onSuggestionTap(widget.text) : null,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: isOnline ? 1.0 : 0.5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF9E9E9E),
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
