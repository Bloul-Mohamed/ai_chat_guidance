import 'package:ai_chat_guidance/core/helpers/shared_prefences.dart';
import 'package:ai_chat_guidance/core/theming/colors.dart';
import 'package:ai_chat_guidance/features/home/ui/widgets/suggestion_card_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatefulWidget {
  const EmptyStateWidget({super.key, required this.onSuggestionTap});
  final Function(String) onSuggestionTap;

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget> {
  String nomArabe = "محمد";
  String nomLatin = "Mohamed";
  String prenomArabe = "أحمد";
  String prenomLatin = "Ahmed";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    try {
      final fetchedNomArabe = await SharedPrefHelper.getString("nomArabe");
      final fetchedNomLatin = await SharedPrefHelper.getString("nomLatin");
      final fetchedPrenomArabe = await SharedPrefHelper.getString("prenomArabe");
      final fetchedPrenomLatin = await SharedPrefHelper.getString("prenomLatin");

      setState(() {
        nomArabe = fetchedNomArabe.isNotEmpty ? fetchedNomArabe : nomArabe;
        nomLatin = fetchedNomLatin.isNotEmpty ? fetchedNomLatin : nomLatin;
        prenomArabe = fetchedPrenomArabe.isNotEmpty ? fetchedPrenomArabe : prenomArabe;
        prenomLatin = fetchedPrenomLatin.isNotEmpty ? fetchedPrenomLatin : prenomLatin;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _getDisplayName() {
    // Check current locale to determine which name to display
    final locale = context.locale.languageCode;
    
    if (locale == 'ar') {
      // Arabic: first name from prenom + full nom
      final firstName = prenomArabe.isNotEmpty 
          ? prenomArabe.split(' ').first 
          : prenomLatin.split(' ').first;
      final lastName = nomArabe.isNotEmpty ? nomArabe : nomLatin;
      return '$firstName $lastName';
    } else {
      // Latin: first name from prenom + full nom
      final firstName = prenomLatin.isNotEmpty 
          ? prenomLatin.split(' ').first 
          : prenomArabe.split(' ').first;
      final lastName = nomLatin.isNotEmpty ? nomLatin : nomArabe;
      return '$firstName $lastName';
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestionTexts = [
      context.tr('suggestion_1'),
      context.tr('suggestion_2'),
      context.tr('suggestion_3'),
      context.tr('suggestion_4'),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),

            // BrainBox Title
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
                children: [
                  TextSpan(text: '${context.tr("welcome")}, '),
                  TextSpan(
                    text: isLoading ? '...' : _getDisplayName(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            ColorsManager.blueColor,
                            ColorsManager.blueColor.withOpacity(0.7),
                          ],
                        ).createShader(Rect.fromLTWH(0, 0, 200.w, 70.h)),
                    ),
                  ),
                  const TextSpan(text: '! 👋'),
                ],
              ),
            ),
            SizedBox(height: 60.h),

            // Suggestion Cards
            ...List.generate(
              suggestionTexts.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SuggestionCardText(
                  text: suggestionTexts[index],
                  onSuggestionTap: widget.onSuggestionTap,
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
