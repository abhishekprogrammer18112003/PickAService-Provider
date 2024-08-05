import 'package:flutter/material.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/helpers/network_helpers.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/features/profile/screens/personal_data.dart';
import 'package:pick_a_service/features/profile/widgets/custom_container_widget.dart';
import 'package:pick_a_service/language_provider.dart';
import 'package:pick_a_service/main.dart';
import 'package:pick_a_service/route/app_pages.dart';
import 'package:pick_a_service/route/custom_navigator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getPersonalData(context);

      final provider = Provider.of<ProfileProvider>(context, listen: false);
      name = provider.profileDataModel["FullName"];
    });
  }

  String name = "";
  // getData() async {
  //   setState(() {
  //     String email = "";
  //     email = SharedPreferencesManager.getString("email_id");
  //     final split = email.split('@');
  //     name = split[0];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<LanguageChangeProvider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await Provider.of<ProfileProvider>(context, listen: false)
              .getPersonalData(context);

          final provider = Provider.of<ProfileProvider>(context, listen: false);
          name = provider.profileDataModel["FullName"];
          provider.getName(name);
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Consumer<ProfileProvider>(
            builder: (context, value, child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 39.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSpacers.height74,
                    Image.asset(AppImages.pick_a_service),
                    CustomSpacers.height40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.welcome,
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondary)),
                      ],
                    ),

                    Text(value.name,
                        style: TextStyle(
                            fontSize: 22.h,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary)),
                    // : Shimmer(
                    //     child: Text("Wait for the name to get",
                    //         style: TextStyle(
                    //             fontSize: 22.h,
                    //             fontWeight: FontWeight.w600,
                    //             color: AppColors.secondary)),
                    //     gradient: LinearGradient(colors: [AppColors.grey])),
                    CustomSpacers.height24,
                    //PERSONEAL DATA
                    GestureDetector(
                      onTap: () {
                        _navigate(context);
                      },
                      child: CustomContainerWidget(
                          image: AppIcons.profileData,
                          title: AppLocalizations.of(context)!.personaldata),
                    ),
                    CustomSpacers.height16,
                    //DELETE ACCOUNT
                    // CustomContainerWidget(
                    //     image: AppIcons.profiledeleteaccount,
                    //     title: AppLocalizations.of(context)!.deleteaccount),

                    // CustomSpacers.height16,

                    //LANGUAGE
                    // CustomContainerWidget(
                    //     image: AppIcons.profileLang, title: "Language"),

                    ExpansionTile(
                      backgroundColor: Color.fromARGB(255, 75, 75, 75),
                      trailing: SizedBox.shrink(),
                      collapsedShape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      collapsedBackgroundColor: Color.fromARGB(255, 75, 75, 75),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppIcons.profileLang,
                            height: 24,
                            width: 40,
                          ),
                          CustomSpacers.width18,
                          Text(
                            AppLocalizations.of(context)!.language,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary),
                          ),
                        ],
                      ),
                      children: [
                        ListTile(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: lang == "en"
                              ? AppColors.secondary
                              : Color.fromARGB(255, 75, 75, 75),
                          horizontalTitleGap: 10,
                          title: Text(
                            'English',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: lang == "en"
                                    ? AppColors.primary
                                    : AppColors.secondary),
                          ),
                          onTap: () {
                            provider.changeLanguage(Locale('en'));
                            SharedPreferencesManager.setString("lang", "en");
                            lang = "en";
                            setState(() {});
                          },
                        ),
                        ListTile(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: lang == "ar"
                              ? AppColors.secondary
                              : Color.fromARGB(255, 75, 75, 75),
                          horizontalTitleGap: 10,
                          title: Text('Arabic',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: lang == "ar"
                                      ? AppColors.primary
                                      : AppColors.secondary)),
                          onTap: () {
                            provider.changeLanguage(Locale('ar'));

                            SharedPreferencesManager.setString("lang", "ar");
                            lang = "ar";
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    CustomSpacers.height16,

                    // //FAQ
                    CustomContainerWidget(image: AppIcons.profileFaq, title: "FAQ"),
                    CustomSpacers.height16,

                    //CONTACT US
                    // GestureDetector(
                    //   onTap: () {
                    //     // NetworkHelpers.launchUrl(url: "https://dev.pickaservice.com/", errorCallback: () {

                    //     // });
                    //     final url = Uri.parse(" https://pickaservice.com/");
                    //     launchUrl(url, mode: LaunchMode.inAppBrowserView);
                    //   },
                    //   child: CustomContainerWidget(
                    //       image: AppIcons.profilecontactus,
                    //       title: AppLocalizations.of(context)!.contactus),
                    // ),
                    // CustomSpacers.height16,

                    //ABOUT
                    GestureDetector(
                      onTap: () {
                        // NetworkHelpers.launchUrl(url: "https://dev.pickaservice.com/", errorCallback: () {

                        // });
                        final url =
                            Uri.parse("https://pickaservice.com/about-us");
                        launchUrl(url, mode: LaunchMode.inAppBrowserView);
                      },
                      child: CustomContainerWidget(
                          image: AppIcons.profileabout,
                          title: AppLocalizations.of(context)!.about),
                    ),
                    CustomSpacers.height16,

                    //LOG OUT
                    GestureDetector(
                      onTap: () {
                        logoutFunc();
                      },
                      child: CustomContainerWidget(
                          image: AppIcons.profileLogout,
                          title: AppLocalizations.of(context)!.logout),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void logoutFunc() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SharedPreferencesManager.setBool("isLogin", false);
                CustomNavigator.pushReplace(
                    context, AppPages.login); // Dismiss the dialog
                // Add your logout logic here
                // For example: Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: PersonalDataPage(), // Replace with your notification screen
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInBack;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class MyExpansionTile extends StatelessWidget {
  MyExpansionTile();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text('Language'), children: [
      Text("English"),
      Text("Arabic"),
    ]);
  }
}
