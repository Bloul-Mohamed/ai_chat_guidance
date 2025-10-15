import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/routing/routes.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo
              Image.asset(
                'assets/icons/login_logo.png', // Replace with your logo path
                width: 154.w,
                height: 184.35.h,
              ),

              SizedBox(height: 40.h),

              // Welcome Text
              Text(
                context.tr('welcome_to'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 8),

              // BrainBox Text
              Text(
                // show text in center the screen
                textAlign: TextAlign.center,
                context.tr("brand"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(),
              // Language Selection
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(RoutesManager.opionsScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.buttonBackground.withOpacity(
                      0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr("language"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        LucideIcons.languages,
                        color: Colors.white,
                        size: 25.w,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              // Log in Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(RoutesManager.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.buttonBackground.withOpacity(
                      0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr("login"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(LucideIcons.shieldCheck, color: Colors.white, size: 25.w),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
