import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        LucideIcons.chevronLeft,
                        color: Colors.white,
                        size: 24.w,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Settings Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                context.tr('settings'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            SizedBox(height: 40.h),

            // Language Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                context.tr('language'),
                style: TextStyle(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Language Options
            _buildLanguageOption(
              context: context,
              languageName: 'العربية',
              languageCode: 'Arabic',
              locale: const Locale('ar'),
              flag: '🇸🇦',
            ),

            SizedBox(height: 12.h),

            _buildLanguageOption(
              context: context,
              languageName: 'English',
              languageCode: 'English',
              locale: const Locale('en'),
              flag: '🇺🇸',
            ),

            SizedBox(height: 12.h),

            _buildLanguageOption(
              context: context,
              languageName: 'Français',
              languageCode: 'French',
              locale: const Locale('fr'),
              flag: '🇫🇷',
            ),

            SizedBox(height: 40.h),
            // show version app in the end of the screen
            Center(
              child: Text(
                context.tr("version_number"),
                style: TextStyle(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageName,
    required String languageCode,
    required Locale locale,
    required String flag,
  }) {
    final isSelected = context.locale == locale;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: InkWell(
        onTap: () async {
          await context.setLocale(locale);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorsManager.blueColor.withOpacity(0.15)
                : ColorsManager.fieldBackground,
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(
                    color: ColorsManager.blueColor.withOpacity(0.5),
                    width: 2,
                  )
                : null,
          ),
          child: Row(
            children: [
              // Flag
              Text(flag, style: TextStyle(fontSize: 28.sp)),

              SizedBox(width: 16.w),

              // Language Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      languageCode,
                      style: TextStyle(
                        color: const Color(0xFF9E9E9E),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Check Icon
              if (isSelected)
                Icon(
                  LucideIcons.check,
                  color: ColorsManager.blueColor,
                  size: 24.w,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
