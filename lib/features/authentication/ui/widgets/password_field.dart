import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/authentication/ui/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PasswordField extends ConsumerStatefulWidget {
  const PasswordField({super.key});

  @override
  ConsumerState<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends ConsumerState<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(passwordControllerProvider);
    
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.fieldBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: context.tr('password'),
          hintStyle: TextStyle(color: const Color(0xFF9E9E9E), fontSize: 16.sp),
          prefixIcon: Icon(
            LucideIcons.keyRound,
            color: const Color(0xFF9E9E9E),
            size: 24.w,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
              color: const Color(0xFF9E9E9E),
              size: 24.w,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
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
