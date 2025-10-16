import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/core/widgets/back_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonWidget(),
                SizedBox(height: 24.h),

                // Title
                Text(
                  context.tr('about_app'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.h),

                // App Info Card
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // App Icon/Logo
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.blueColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          LucideIcons.bot,
                          color: ColorsManager.blueColor,
                          size: 40.w,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // App Name
                      Text(
                        context.tr('app_name'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Version
                      Text(
                        context.tr('version'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Description
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.info,
                            color: ColorsManager.blueColor,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr('about'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr('app_description'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 15.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Creator Info
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.lightbulb,
                            color: ColorsManager.blueColor,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr('created_by'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr('creator_name'),
                        style: TextStyle(
                          color: ColorsManager.blueColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        context.tr('creator_role'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Features
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.sparkles,
                            color: ColorsManager.blueColor,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr('features'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildFeatureItem(
                        context,
                        LucideIcons.messageSquare,
                        context.tr('feature_chat'),
                      ),
                      SizedBox(height: 12.h),
                      _buildFeatureItem(
                        context,
                        LucideIcons.fileText,
                        context.tr('feature_pdf'),
                      ),
                      SizedBox(height: 12.h),
                      _buildFeatureItem(
                        context,
                        LucideIcons.zap,
                        context.tr('feature_ai'),
                      ),
                      SizedBox(height: 12.h),
                      _buildFeatureItem(
                        context,
                        LucideIcons.languages,
                        context.tr('feature_multilingual'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Contact/Support
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mail,
                            color: ColorsManager.blueColor,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr('contact'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr('contact_description'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 15.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Copyright
                Center(
                  child: Text(
                    context.tr('copyright'),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsManager.background,
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: ColorsManager.blueColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ColorsManager.blueColor, size: 16.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}

