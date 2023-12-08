import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'check_screen.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckScreen()),
              );
            },
            minWidth: double.infinity,
            height: 45,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              "Check",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            minWidth: double.infinity,
            height: 45,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 48),

          // Hello
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Hello',
              style: GoogleFonts.notoSerif(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          // Let's check it!
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's check it!",
              style: GoogleFonts.notoSerif(
                  fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          // Leesaw
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Leesaw',
              style: GoogleFonts.notoSerif(
                  fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          // You missed 2 days ago
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'You missed 2 days ago',
              style: GoogleFonts.notoSerif(fontSize: 15),
            ),
          ),

          // divider line
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        // mini: true,
        shape: CircleBorder(),
      ),
    );
  }
}
