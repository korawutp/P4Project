import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:workproject/features/navigationmenu/components/animated_bar.dart';
import 'package:workproject/screens/2_classcheck/course/screens/course.dart';
import 'package:workproject/features/navigationmenu/models/rive_asset.dart';
import 'package:workproject/screens/1_home/home.dart';
import 'package:workproject/screens/3_history/history.dart';
import 'package:workproject/screens/4_profile/profile.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/rive/rive_utils.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavBarState();
}

class _NavBarState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CourseScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  RiveAsset selectedBottomNav = NavMenu.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: MyAppColors.c2,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                NavMenu.length,
                (index) => GestureDetector(
                  onTap: () {
                    NavMenu[index].input!.change(true);
                    if (NavMenu[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = NavMenu[index];
                        _selectedIndex = index;
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      NavMenu[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                          isActive: NavMenu[index] == selectedBottomNav),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              NavMenu[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(NavMenu.first.src,
                              artboard: NavMenu[index].artboard,
                              onInit: (artboard) {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    StateMachineName:
                                        NavMenu[index].stateMachineName);
                            NavMenu[index].input =
                                controller.findSMI("active") as SMIBool;
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
