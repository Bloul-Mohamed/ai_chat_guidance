import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/core/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [BackButtonWidget()],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsManager.background,
    );
  }
}
