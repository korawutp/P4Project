import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/widgets/home_days.dart';
import 'package:workproject/screens/1_home/widgets/home_searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //* Hi Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* Hi User!
                    Text(
                      'Hello Student!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //* notification
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blue[600],
                        fixedSize: const Size(50, 50),
                      ),
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                //* search bar
                HomeSearchBar(),

                SizedBox(
                  height: 20,
                ),

                //* mini history page
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How was your class today?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Color(0xFF1A1C20),
                              fontSize: 12,
                            ),
                      ),
                    )
                  ],
                ),

                //* mini history
                HomeDays(),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
