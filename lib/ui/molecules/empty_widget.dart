import 'package:pick_a_service/core/utils/screen_utils.dart';

import '../../core/app_imports.dart';
import 'custom_button.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {Key? key,
      required this.imagePath,
      required this.title,
      this.description,
      this.actionHandler,
      this.actionText})
      : super(key: key);

  final String imagePath;
  final String title;
  final String? description;
  final String? actionText;
  final VoidCallback? actionHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 165.w,
          height: 165.w,
          fit: BoxFit.cover,
        ),
        CustomSpacers.height40,
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyle18w600Primary.copyWith(
            color: AppColors.tertiaryText,
          ),
        ),
        CustomSpacers.height8,
        if (description != null)
          Text(
            description!,
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle12w400Primary.copyWith(
              color: AppColors.tertiaryText,
            ),
          ),
        CustomSpacers.height24,
        Visibility(
          visible: actionHandler != null,
          child: SizedBox(
            width: 200.w,
            child: CustomButton(
              strButtonText: actionText ?? '',
              buttonAction: actionHandler ?? () {},
              dHeight: 50.h,
            ),
          ),
        ),
      ],
    );
  }
}
