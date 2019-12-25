import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_to_do/screens/tasks_screen.dart';
import 'package:tasks_to_do/widgets/raised_gradient_button.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.2,
          ),
          SizedBox(
            height: size.height * 0.25,
            width: size.width * 0.4,
            child: Image.asset("assets/images/Group_12.png"),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Text(
            "Tasks To Do",
            style: Theme.of(context).textTheme.subhead,
          ),
          Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Text(
              "Tasks To Do is a simple to do app that helps you organize your tasks, achieve your personal goals and reflect on your life.",
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RaisedGradientButton(
            gradient: LinearGradient(
                colors: [Color(0xff92d5e0), Color(0xff26d7f3)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            width: size.width * 0.7,
            onPressed: () {
              _updateSeen();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (c) => TasksScreen(),
                ),
              );
            },
            child: Text(
              "Get Started",
            ),
          ),
        ],
      ),
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
