import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/networking/auth_user_login.dart';
import 'package:ai_chat_guidance/core/networking/get_user_dias_info.dart';
import 'package:ai_chat_guidance/core/routing/routes.dart';
import 'package:ai_chat_guidance/core/shared/providers/connection_state_provider.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/authentication/data/models/login_request_body.dart';
import 'package:ai_chat_guidance/features/authentication/ui/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginButtonWidget extends ConsumerStatefulWidget {
  const LoginButtonWidget({super.key});

  @override
  ConsumerState<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends ConsumerState<LoginButtonWidget> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    final registerNumber = ref
        .read(registerNumberControllerProvider)
        .text
        .trim();
    final password = ref.read(passwordControllerProvider).text.trim();

    // Validation
    if (registerNumber.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = context.tr('please_fill_all_fields');
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Create login request
      final loginRequest = LoginRequestBody(
        username: registerNumber,
        password: password,
      );

      // Call login API
      final apiLoginService = ApiLoginService();
      final loginResponse = await apiLoginService.login(loginRequest);

      // If login successful, fetch user info
      if (loginResponse.token != null) {
        final apiDiasUserService = ApiDiasUserService();
        await apiDiasUserService.userDiaInfo();

        // Navigate to chat screen
        if (mounted) {
          context.pushNamedAndRemoveUntil(
            RoutesManager.chatScreen,
            predicate: (route) => false,
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(internetProvider);

    return internetStatus.when(
      data: (isOnline) {
        return Column(
          children: [
            // Error Message
            if (_errorMessage != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: ColorsManager.redColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorsManager.redColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.alertCircle,
                      color: ColorsManager.redColor,
                      size: 20.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: ColorsManager.redColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Connection Status Indicator
            if (!isOnline)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: ColorsManager.redColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorsManager.redColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.wifiOff,
                      color: ColorsManager.redColor,
                      size: 20.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        context.tr('no_internet_connection'),
                        style: TextStyle(
                          color: ColorsManager.redColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: (isOnline && !_isLoading) ? _handleLogin : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (isOnline && !_isLoading)
                      ? ColorsManager.buttonBackground.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.3),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.tr('logging_in'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        context.tr('login'),
                        style: TextStyle(
                          color: (isOnline && !_isLoading)
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
      loading: () => SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                context.tr('checking_connection'),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) => SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            context.tr('error_checking_connection'),
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

