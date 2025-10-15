import 'package:ai_chat_guidance/core/shared/providers/connection_state_provider.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OfflineModeAnimationScreen extends ConsumerStatefulWidget {
  const OfflineModeAnimationScreen({super.key});

  @override
  ConsumerState<OfflineModeAnimationScreen> createState() =>
      _OfflineModeAnimationScreenState();
}

class _OfflineModeAnimationScreenState
    extends ConsumerState<OfflineModeAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(internetProvider);

    return internetStatus.when(
      data: (isOnline) {
        if (!isOnline) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: ColorsManager.redColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorsManager.redColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.wifiOff,
                  color: ColorsManager.redColor,
                  size: 18.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr('no_internet_connection'),
                  style: TextStyle(
                    color: ColorsManager.redColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}
