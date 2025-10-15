import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/routing/routes.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SupportAndAboutOption extends StatelessWidget {
  const SupportAndAboutOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Support Button
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(RoutesManager.supportScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.redColor.withOpacity(0.25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr("support"),
                    style: TextStyle(
                      color: ColorsManager.redColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    LucideIcons.phoneCall,
                    color: ColorsManager.redColor,
                    size: 20.w,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Developer Button
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(RoutesManager.aboutScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.blueColor.withOpacity(0.25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr("about"),
                    style: TextStyle(
                      color: ColorsManager.blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    LucideIcons.badgeInfo,
                    color: ColorsManager.blueColor,
                    size: 22.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
