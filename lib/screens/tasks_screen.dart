import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasks_to_do/widgets/tasks_list.dart';
import 'package:tasks_to_do/models/task_data.dart';
import 'package:tasks_to_do/widgets/add_tasks.dart';

class TasksScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () =>
            this._scaffoldKey.currentState.showBottomSheet((ctx) => AddTask()),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.1,
              right: 30.0,
              left: 30.0,
              bottom: size.height * 0.05,
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    color: Colors.lightBlueAccent,
                    size: 35.0,
                  ),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Tasks To Do',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      'You have ${Provider.of<TaskData>(context).taskCount} Tasks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
