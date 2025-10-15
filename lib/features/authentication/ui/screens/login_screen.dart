import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/core/widgets/back_button_widget.dart';
import 'package:ai_chat_guidance/features/authentication/ui/widgets/login_button_widget.dart';
import 'package:ai_chat_guidance/features/authentication/ui/widgets/password_field.dart';
import 'package:ai_chat_guidance/features/authentication/ui/widgets/register_number_field.dart';
import 'package:ai_chat_guidance/features/authentication/ui/widgets/support_and_about_option.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // Back Button
                BackButtonWidget(),

                SizedBox(height: 60.h),

                // Login Your Account Title
                buildHeaderScreen(),
                SizedBox(height: 40.h),
                // Register Number TextField
                RegisterNumberField(),
                SizedBox(height: 20.h),
                // Password TextField
                PasswordField(),
                SizedBox(height: 40.h),

                // Login Button with Internet Check
                LoginButtonWidget(),
                SizedBox(height: 120.h),

                // Continue With Accounts Text
                buildTextOption(),
                SizedBox(height: 40.h),
                SupportAndAboutOption(),
                // Support and Developer Buttons
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextOption() {
    return Center(
      child: Text(
        context.tr('another_options_to_continue'),
        style: TextStyle(
          color: const Color(0xFF9E9E9E),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget buildHeaderScreen() {
    return Text(
      context.tr('login_your_account'),
      style: TextStyle(
        color: Colors.white,
        fontSize: 40.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}
