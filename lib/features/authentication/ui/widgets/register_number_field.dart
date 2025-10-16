import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/authentication/ui/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegisterNumberField extends ConsumerWidget {
  const RegisterNumberField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(registerNumberControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.fieldBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: context.tr('enter_your_register_number'),
          hintStyle: TextStyle(color: const Color(0xFF9E9E9E), fontSize: 16.sp),
          prefixIcon: Icon(
            LucideIcons.creditCard,
            color: const Color(0xFF9E9E9E),
            size: 24.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 18.h,
          ),
        ),
      ),
    );
  }
}

