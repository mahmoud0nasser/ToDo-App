import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
  });
  final String text;
  final VoidCallback onPressed;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      /* onPressed: () {
        controller.nextPage(
          duration: Duration(
            milliseconds: 500,
          ),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }, */
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStatePropertyAll(
              backgroundColor,
            ),
          ),
      /* style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    ),
                  ), */
      child: Text(
        text,
        // AppStrings.next,
      ),
    );
  }
}
