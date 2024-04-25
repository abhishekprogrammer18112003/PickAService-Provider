import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/features/home/screens/home_screen.dart';
import 'package:pick_a_service/features/profile/data/profile_provider.dart';
import 'package:pick_a_service/features/profile/screens/profile_screen.dart';
import 'package:pick_a_service/features/service%20history/screens/service_history_screen.dart';
import 'package:provider/provider.dart';

class NavBarScreen extends StatefulWidget {
  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;
  

  final List<Widget> _pages = [
    const HomeScreen(),
    const ServiceHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    

      await Provider.of<ProfileProvider>(context, listen: false)
          .getPersonalData(context);

      final provider = Provider.of<ProfileProvider>(context, listen: false);

      provider.getName(provider.profileDataModel["FullName"]);
      print(provider.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.primary,
      
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _pages[_selectedIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
      ),
      bottomNavigationBar: Container(
        height : 83.h,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // shape: BoxShape.circle  
        ),
        child: Material(
          
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
          
            iconSize: 24.h
            ,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: const Color.fromARGB(255, 186, 186, 186),
          ),
        ),
      ),
    );
  }
  
}



