import 'package:flutter/material.dart';

class EmptyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset("assets/images/Group_10.png"),
            SizedBox(
              height: 50,
            ),
            Text(
              "No Tasks",
              style: Theme.of(context).textTheme.subhead,
            ),
            Text("You have no tasks to do"),
          ],
        ),
      ),
    );
  }
}
