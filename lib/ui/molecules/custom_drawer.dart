// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../core/app_imports.dart';
// import '../../core/helpers/network_helpers.dart';
// import '../../core/helpers/scaffold_helpers.dart';
// import '../../core/helpers/ui_helpers.dart';
// import '../../core/helpers/user_helpers.dart';
// import '../../features/dashboard/presentation/widgets/feedback_form.dart';
// import '../../route/app_pages.dart';
// import '../../route/custom_navigator.dart';
// import 'custom_image.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   Future<void> _launchUrl(String link) async {
//     await NetworkHelpers.launchUrl(
//       url: link,
//       errorCallback: () => UIHelper.showToast(
//         msg: 'Failed to launch URL.',
//         type: ToastType.Error,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.65,
//       child: Drawer(
//         backgroundColor: AppColors.primary,
//         shape: const RoundedRectangleBorder(),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(
//             top: 64.h,
//             bottom: 58.h,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildBackButton(context),
//               CustomSpacers.height18,
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: buildProfileSection(),
//               ),
//               CustomSpacers.height40,
//               buildLinkItems(),
//               CustomSpacers.height80,
//               buildSocialIcons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildLinkItem({
//     required String iconPath,
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: 34.w,
//           vertical: 12.h,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SvgPicture.asset(
//               iconPath,
//               color: AppColors.white,
//             ),
//             CustomSpacers.width10,
//             Text(
//               text,
//               style: AppTextStyles.textStyle16w500Primary2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildLinkItems() {
//     final items = [
//       buildLinkItem(
//         iconPath: AppIcons.bookmark,
//         text: 'Saved jobs',
//         onTap: () {
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushTo(
//               kNavigatorKey.currentContext!,
//               AppPages.savedJobs,
//               arguments: {
//                 'fromDrawer': true,
//               },
//             );
//           }
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.brief,
//         text: 'Applied jobs',
//         onTap: () {
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushTo(
//               kNavigatorKey.currentContext!,
//               AppPages.appliedJobs,
//             );
//           }
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.clock,
//         text: 'Interviews',
//         onTap: () {
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushTo(
//               kNavigatorKey.currentContext!,
//               AppPages.interview,
//             );
//           }
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.message,
//         text: 'Any feedback?',
//         onTap: () async {
//           if (kNavigatorKey.currentContext == null) {
//             return;
//           }
//           CustomNavigator.pop(kNavigatorKey.currentContext!);
//           await ScaffoldHelpers.showCustomDialog(
//             kNavigatorKey.currentContext!,
//             const FeedbackForm(),
//           );
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.share,
//         text: 'Invite a friend',
//         onTap: () {
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushTo(
//               kNavigatorKey.currentContext!,
//               AppPages.referral,
//             );
//           }
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.circleQuestion,
//         text: 'Help and support',
//         onTap: () {
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushTo(
//               kNavigatorKey.currentContext!,
//               AppPages.support,
//             );
//           }
//         },
//       ),
//       buildLinkItem(
//         iconPath: AppIcons.exit,
//         text: 'Logout',
//         onTap: () async {
//           UserHelpers.clearUser();
//           await FirebaseAuth.instance.signOut();
//           if (kNavigatorKey.currentContext != null) {
//             CustomNavigator.pushReplace(
//               kNavigatorKey.currentContext!,
//               AppPages.login,
//             );
//           }
//         },
//       ),
//     ];

//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (context, index) => items[index],
//     );
//   }

//   Widget buildSocialIcons() {
//     return Align(
//       alignment: Alignment.center,
//       child: SizedBox(
//         width: 200.w,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Follow us upon',
//               style: AppTextStyles.textStyleLato16w800Primary2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () => _launchUrl(URL_FACEBOOK),
//                   icon: SvgPicture.asset(
//                     AppIcons.facebook,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => _launchUrl(URL_INSTAGRAM),
//                   icon: SvgPicture.asset(
//                     AppIcons.instagram,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => _launchUrl(URL_LINKEDIN),
//                   icon: SvgPicture.asset(
//                     AppIcons.linkedIn,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBackButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         CustomNavigator.pop(context);
//       },
//       child: Padding(
//           padding: EdgeInsets.only(left: 34.w),
//           child: SvgPicture.asset(
//             AppIcons.menuBack,
//             color: AppColors.white,
//           )),
//     );
//   }

//   Widget _buildPlaceholder() {
//     return Container(
//       width: 55,
//       height: 55,
//       decoration: const ShapeDecoration(
//         shape: CircleBorder(),
//         image: DecorationImage(
//           image: AssetImage(
//             AppImages.profilePlaceholder,
//           ),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget buildProfileSection() {
//     final String? firstName = UserHelpers.userDetails?.firstName;
//     final String? lastName = UserHelpers.userDetails?.lastName;
//     final String? jobType = UserHelpers.userDetails?.jobType;
//     final String? profileImageUrl = UserHelpers.userDetails?.profileImageUrl;

//     return GestureDetector(
//       onTap: () {
//         if (kNavigatorKey.currentContext != null) {
//           CustomNavigator.pushTo(
//             kNavigatorKey.currentContext!,
//             AppPages.personalInfo,
//           );
//         }
//       },
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//             color: AppColors.darkBlue,
//             borderRadius: BorderRadius.horizontal(right: Radius.circular(5))),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 34.w,
//             vertical: 10.h,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               profileImageUrl == null
//                   ? _buildPlaceholder()
//                   : CustomImage.circle(
//                       size: 55,
//                       imageUrl: profileImageUrl,
//                     ),
//               CustomSpacers.width8,
//               Expanded(
//                 child: ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   minVerticalPadding: 0.0,
//                   minLeadingWidth: 0.0,
//                   title: Text(
//                     firstName != null && lastName != null
//                         ? '$firstName $lastName'
//                         : '',
//                     style: AppTextStyles.textStyleLato16w800White,
//                   ),
//                   subtitle: Text(
//                     jobType ?? '',
//                     style: AppTextStyles.textStyle12w400Primary2,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
