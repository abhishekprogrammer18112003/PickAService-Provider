import 'package:pick_a_service/core/utils/screen_utils.dart';

import '../../core/app_imports.dart';

class CustomTimelineTile extends StatelessWidget {
  const CustomTimelineTile({
    super.key,
    required this.indicatorIcon,
    required this.title,
    required this.subtitle,
    required this.desc,
  });

  final IconData indicatorIcon;
  final String title;
  final String subtitle;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: AppColors.primaryBorder,
                width: 1.w,
                height: double.infinity,
              ),
              CircleAvatar(
                radius: 12.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  indicatorIcon,
                  color: AppColors.white,
                  size: 12.r,
                ),
              ),
            ],
          ),
          CustomSpacers.width14, 
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 16.h
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: AppTextStyles.textStyleLato12w800Secondary,
                  ),
                  Text(
                    subtitle,
                    softWrap: true,
                    style: AppTextStyles.textStyle12w400Modal,
                  ),
                  Text(
                    desc,
                    softWrap: true,
                    style: AppTextStyles.textStyle12w400Tertiary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
