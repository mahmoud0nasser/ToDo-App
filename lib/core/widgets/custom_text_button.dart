import 'package:flutter/material.dart';

import '../../features/auth/data/model/on_boarding_model.dart';
import '../utils/app_strings.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      /* onPressed: () {
        // controller.jumpToPage(2);
        controller.jumpToPage(OnBoardingModel.onBoardingScreens.length - 1);
      }, */
      child: Text(
        text,
        // AppStrings.skip,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
