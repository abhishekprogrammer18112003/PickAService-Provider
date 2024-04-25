import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/features/home/models/notification_model.dart';
import 'package:pick_a_service/features/home/screens/checklist.dart';
import 'package:pick_a_service/features/home/screens/direction_page.dart';
import 'package:pick_a_service/features/home/screens/home_screen.dart';
import 'package:pick_a_service/features/home/screens/invoice.dart';
import 'package:pick_a_service/features/home/screens/notification_screen.dart';
import 'package:pick_a_service/features/home/screens/orders_screen.dart';
import 'package:pick_a_service/features/home/screens/view_checklist.dart';
import 'package:pick_a_service/features/home/screens/view_invoice.dart';
import 'package:pick_a_service/features/onboarding/screens/login_screen.dart';
import 'package:pick_a_service/features/onboarding/screens/splash_screen.dart';
import 'package:pick_a_service/features/profile/screens/change_password.dart';
import 'package:pick_a_service/features/profile/screens/edit_profile_data.dart';
import 'package:pick_a_service/features/profile/screens/personal_data.dart';
import 'package:pick_a_service/features/profile/screens/profile_screen.dart';
import 'package:pick_a_service/features/service%20history/models/completed_task.dart';
import 'package:pick_a_service/features/service%20history/models/schedule_history_model.dart';
import 'package:pick_a_service/features/service%20history/screens/pending_orders_details_completed.dart';
import 'package:pick_a_service/features/service%20history/screens/pending_orders_details_screen.dart';
import 'package:pick_a_service/features/service%20history/screens/service_history_screen.dart';
import 'package:pick_a_service/navbar.dart';

import '../core/app_imports.dart';
import 'app_pages.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case AppPages.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );

      case AppPages.navbar:
        return MaterialPageRoute(
          builder: (context) => NavBarScreen(),
          settings: settings,
        );

      case AppPages.notification:
        return MaterialPageRoute(
          builder: (context) => NotificationScreen(),
          settings: settings,
        );

      case AppPages.orders:
        return MaterialPageRoute(
          builder: (context) => OrdersScreen(
            arguments: settings.arguments as Map<String, dynamic>,
            data: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );
      case AppPages.direction:
        return MaterialPageRoute(
          builder: (context) => DirectionPage(
            arguments: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );
      case AppPages.pendingordersdetails:
        return MaterialPageRoute(
          builder: (context) => PendingOrdersDetailsScreen(
              arguments: settings.arguments as Map<String, dynamic>,
              data: settings.arguments as ScheduleHistoryModel),
          settings: settings,
        );

      case AppPages.pendingordersdetailsCompleted:
        return MaterialPageRoute(
          builder: (context) => PendingOrdersDetailsCompletedScreen(
              arguments: settings.arguments as Map<String, dynamic>,
              data: settings.arguments as CompletedTasksModel),
          settings: settings,
        );

      case AppPages.checklist:
        return MaterialPageRoute(
          builder: (context) => CheckListScreen(
            arguments: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );

      case AppPages.viewChecklist:
        return MaterialPageRoute(
          builder: (context) => ViewCheckListScreen(
            arguments: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );

      case AppPages.invoice:
        return MaterialPageRoute(
          builder: (context) => InvoiceScreen(
            arguments: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );

      case AppPages.viewInvoice:
        return MaterialPageRoute(
          builder: (context) => ViewInvoiceScreen(
            arguments: settings.arguments as AcceptedOrdersModel,
          ),
          settings: settings,
        );

      case AppPages.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );

      case AppPages.service:
        return MaterialPageRoute(
          builder: (context) => ServiceHistoryScreen(),
          settings: settings,
        );

      case AppPages.profile:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
          settings: settings,
        );

      case AppPages.personalData:
        return MaterialPageRoute(
          builder: (context) => PersonalDataPage(),
          settings: settings,
        );

      case AppPages.editPersonalData:
        return MaterialPageRoute(
          builder: (context) => EditProfileDataPage(
            data: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );

      case AppPages.changePassword:
        return MaterialPageRoute(
          builder: (context) => ChangePassword(),
          settings: settings,
        );

      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }
}
