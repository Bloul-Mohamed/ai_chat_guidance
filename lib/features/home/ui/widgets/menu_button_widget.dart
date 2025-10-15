import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(LucideIcons.moreHorizontal, color: Colors.white, size: 24.w),
        onPressed: () {
          context.pushNamed(RoutesManager.opionsScreen);
        },
      ),
    );
  }
}
