import 'package:ai_chat_guidance/core/helpers/extensions.dart';
import 'package:ai_chat_guidance/core/helpers/shared_prefences.dart';
import 'package:ai_chat_guidance/core/routing/routes.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'assets/images/onboarding_1.png',
      titleKey: 'onboarding_title_1',
      descriptionKey: 'onboarding_desc_1',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_2.png',
      titleKey: 'onboarding_title_2',
      descriptionKey: 'onboarding_desc_2',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_3.png',
      titleKey: 'onboarding_title_3',
      descriptionKey: 'onboarding_desc_3',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await SharedPrefHelper.setData('onboarding_completed', true);
    if (mounted) {
      context.pushNamedAndRemoveUntil(
        RoutesManager.welcomeScreen,
        predicate: (Route<dynamic> route) => false,
      );
    }
  }

  void _nextPage() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back and Menu buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(
                          RoutesManager.welcomeScreen,
                          predicate: (Route<dynamic> route) => false,
                        );
                      },
                      icon: Icon(
                        LucideIcons.skipBack,
                        color: Colors.grey.shade500,
                        size: 28.sp,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),

                  // Menu Button (Three Dots)
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.pushNamed(RoutesManager.opionsScreen);
                      },
                      icon: Icon(
                        LucideIcons.languages,
                        color: Colors.grey.shade500,
                        size: 28.sp,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),

            // Page Indicators
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey.shade600,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  spacing: 8.w,
                ),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child: Row(
                  children: [
                    // Back Button
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          final currentPage = _pageController.hasClients
                              ? (_pageController.page?.round() ?? 0)
                              : 0;
                          return GestureDetector(
                            onTap: currentPage > 0 ? _previousPage : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35.r),
                                  bottomLeft: Radius.circular(35.r),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  // check if localization in ar mode or en mode
                                  locale == 'ar'
                                      ? LucideIcons.arrowRightCircle
                                      : LucideIcons.arrowLeftCircle,
                                  color: currentPage > 0
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Divider
                    Container(
                      width: 1.5.w,
                      height: 40.h,
                      color: Colors.white.withOpacity(0.2),
                    ),

                    // Next/Get Started Button
                    Expanded(
                      child: GestureDetector(
                        onTap: _nextPage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35.r),
                              bottomRight: Radius.circular(35.r),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              // check if localization in ar mode or en mode
                              locale == 'ar'
                                  ? LucideIcons.arrowLeftCircle
                                  : LucideIcons.arrowRightCircle,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Image.asset(data.image, height: 400.h, fit: BoxFit.contain),

          SizedBox(height: 5.h),

          // Title
          Text(
            context.tr(data.titleKey),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),

          SizedBox(height: 5.h),

          // Description
          Text(
            context.tr(data.descriptionKey),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String titleKey;
  final String descriptionKey;

  OnboardingData({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}
