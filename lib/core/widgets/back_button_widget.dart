import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorsManager.fieldBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(LucideIcons.chevronLeft, color: Colors.white, size: 24.w),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
