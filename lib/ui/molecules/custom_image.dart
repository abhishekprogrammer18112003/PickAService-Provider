import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum _Shape { square, circle }

class CustomImage extends StatelessWidget {
  const CustomImage.square({
    super.key,
    required this.size,
    required this.imageUrl,
  }) : shape = _Shape.square;

  const CustomImage.circle({
    super.key,
    required this.size,
    required this.imageUrl,
  }) : shape = _Shape.circle;

  final double size;
  final String imageUrl;
  final _Shape shape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, 
      height: size, 
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: shape == _Shape.square
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.25 * size),
                  side: const BorderSide(color: AppColors.greyBorder),
                )
              : const CircleBorder(
                  side: BorderSide(color: AppColors.greyBorder),
                ),
          color: AppColors.greyBackground,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
