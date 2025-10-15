import 'package:ai_chat_guidance/core/routing/app_router.dart';
import 'package:ai_chat_guidance/features/authentication/ui/screens/login_screen.dart';
import 'package:ai_chat_guidance/features/authentication/ui/screens/welcome_screen.dart';
import 'package:ai_chat_guidance/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: F.title,
        theme: ThemeData(primarySwatch: Colors.blue),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: AppRouter().generateRoute,
        home: _flavorBanner(child: OnboardingScreen(), show: kDebugMode),
      ),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          location: BannerLocation.topStart,
          message: F.name,
          color: Colors.green.withAlpha(150),
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 1.0,
          ),
          child: child,
        )
      : Container(child: child);
}
