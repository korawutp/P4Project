import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:workproject/screens/2_classcheck/widgets/classcheck_his.dart';
import 'package:workproject/screens/2_classcheck/widgets/classcheck_missed.dart';
import 'package:workproject/screens/2_classcheck/widgets/countdowntimer.dart';

class Classevent extends StatefulWidget {
  const Classevent({Key? key}) : super(key: key);

  @override
  State<Classevent> createState() => _ClasseventState();
}

class _ClasseventState extends State<Classevent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF1F1),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Class Check'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 320,
                height: 107,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Topic name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Created time',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'By',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: 100,
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      side: BorderSide.none),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return GiffyDialog.image(
                                            Image.network(
                                              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(
                                              'Image Animation',
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                              'This is a image animation dialog box. This library helps you easily create fancy giffy dialog.',
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'CANCEL'),
                                                child: const Text('CANCEL'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'check!',
                                    style: TextStyle(fontSize: 14),
                                  )),
                            )),
                      ],
                    ),
                    LinearTimer(
                      durationMinutes: 2, // Adjust timer duration here
                      onTimerFinish: () {
                        print('Timer finished!');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClasseventHis(),
              const SizedBox(
                height: 10,
              ),
              ClasseventMissed(),
            ],
          ),
        ),
      ),
    );
  }
}
