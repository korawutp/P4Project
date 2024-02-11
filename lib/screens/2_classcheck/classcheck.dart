import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


//* first page when don't have events or nothing to check

class Checkdrop extends StatelessWidget {
  const Checkdrop({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFCF1F1),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset('assets/images/home_images/meow_loading.json',
                    height: 150, width: 150),
                Text(
                  "You're all check HOORAY!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//*first page when teacher create check event
