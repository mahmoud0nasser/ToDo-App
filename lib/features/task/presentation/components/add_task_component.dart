import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';

class AddTaskComponent extends StatelessWidget {
  const AddTaskComponent({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.validator,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 8.0.h,
        ),
        TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            // Hint
            hintText: hintText,
            suffixIcon: suffixIcon,
            /* // enabled border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // focused border
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // Hint
                  hintText: AppStrings.titleHint,
                  hintStyle: Theme.of(context).textTheme.displayMedium,
                  // fill Color
                  fillColor: AppColors.lightBlack,
                  filled: true, */
          ),
        ),
      ],
    );
  }
}
