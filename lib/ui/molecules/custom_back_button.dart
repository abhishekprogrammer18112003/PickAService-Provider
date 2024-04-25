import '../../core/app_imports.dart';

class CustombackButton extends StatelessWidget {
  final Function onTap;
  const CustombackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: AppColors.primaryBorder),
        ),
        child: const Center(
            child: Icon(Icons.arrow_back_ios_new,
                color: AppColors.primaryText, size: 20)),
      ),
    );
  }
}
