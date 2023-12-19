import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/home.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final darkMode = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyAppColors.primaryColor,
        backgroundColor:
            darkMode ? MyAppColors.darkContainer : MyAppColors.lightContainer,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              MyAppImage.home,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            icon: Image.asset(
              darkMode ? MyAppImage.homeDark : MyAppImage.homeLight,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              MyAppImage.timeCheck,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            icon: Image.asset(
              darkMode ? MyAppImage.timeCheckDark : MyAppImage.timeCheckLight,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            label: 'Check',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              MyAppImage.history,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            icon: Image.asset(
              darkMode ? MyAppImage.historyDark : MyAppImage.historyLight,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              MyAppImage.profile,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            icon: Image.asset(
              darkMode ? MyAppImage.profileDark : MyAppImage.profileLight,
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}








/// -- Old Navigation Menu with A Icon --


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:workproject/features/roll_call/screens/home/home.dart';
// import 'package:workproject/utils/constants/colors.dart';
// import 'package:workproject/utils/helpers/helper_functions.dart';

// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     final darkMode = MyAppHelperFunctions.isDarkMode(context);

//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           height: 80,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) {
//             controller.selectedIndex.value = index;
//           },
//           backgroundColor: darkMode ? MyAppColors.black : MyAppColors.white,
//           indicatorColor: darkMode
//               ? MyAppColors.white.withOpacity(0.1)
//               : MyAppColors.black.withOpacity(0.1),
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Iconsax.home_2),
//               label: 'Home',
//             ),
//             NavigationDestination(
//               icon: Icon(Iconsax.tick_circle),
//               label: 'Check',
//             ),
//             NavigationDestination(
//               icon: Icon(Iconsax.calendar_1),
//               label: 'History',
//             ),
//             NavigationDestination(
//               icon: Icon(Iconsax.user),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;

//   final screens = [
//     const HomeScreen(),
//     Container(
//       color: Colors.green,
//     ),
//     Container(
//       color: Colors.blue,
//     ),
//     Container(
//       color: Colors.red,
//     ),
//   ];
// }