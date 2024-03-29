import 'package:flutter/material.dart';

import '../../../core/constants/colors/app_colors.dart';

class BackToButton extends StatelessWidget {
  const BackToButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteLikeColor,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textDarkColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
