import 'package:flutter/material.dart';
import 'package:tasks_to_do/screens/onBoarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:tasks_to_do/screens/tasks_screen.dart';
import 'models/task_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _screen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool seen = pref.getBool("seen");
  if (seen == false || seen == null) {
    _screen = OnBoardingScreen();
  } else {
    _screen = TasksScreen();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskData(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        title: "Tasks to do",
        debugShowCheckedModeBanner: false,
        home: _screen,
        theme: Theme.of(context).copyWith(
          textTheme: TextTheme(
            body1: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            headline: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 30,
            ),
            subhead: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
