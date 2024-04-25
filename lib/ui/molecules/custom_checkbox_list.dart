// import 'package:flutter/material.dart';
//
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_text_styles.dart';
//
// class CustomCheckboxList extends StatelessWidget {
//   final Set<String> items;
//   final Set<String> selectedItems;
//   final void Function(String, bool?) onItemTap;
//
//   const CustomCheckboxList(
//       {Key? key,
//       required this.items,
//       required this.onItemTap,
//       required this.selectedItems})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       itemCount: items.length,
//       itemBuilder: (context, index) => _CustomCheckboxTile(
//         key: UniqueKey(),
//         text: items.elementAt(index),
//         isSelected: selectedItems.contains(items.elementAt(index)),
//         onChanged: (value) => onItemTap(items.elementAt(index), value),
//       ),
//       separatorBuilder: (context, index) => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Divider(),
//       ),
//     );
//   }
// }
//
// class _CustomCheckboxTile extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//   final void Function(bool?) onChanged;
//
//   const _CustomCheckboxTile(
//       {Key? key,
//       required this.text,
//       required this.isSelected,
//       required this.onChanged})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       value: isSelected,
//       onChanged: onChanged,
//       title: Text(
//         text,
//         style: AppTextStyles.textStyle14w400Secondary.copyWith(
//           color: AppColors.black,
//         ),
//       ),
//       checkboxShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2),
//       ),
//       side: BorderSide(color: AppColors.checkboxBorder, width: 2),
//     );
//   }
// }
