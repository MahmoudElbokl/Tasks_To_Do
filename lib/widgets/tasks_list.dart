import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasks_to_do/models/task_data.dart';
import 'package:tasks_to_do/models/task_model.dart';
import 'package:tasks_to_do/widgets/empty_tasks.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Color> _colors = [
    Colors.redAccent,
    Colors.lightBlue,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.deepPurple,
  ];

  Random _randomIndex = Random();
  List<Task> tasks = <Task>[];
  bool first = true;

  @override
  void didChangeDependencies() async {
    if (first) {
      tasks = await Provider.of<TaskData>(context).readToDoList();
      first = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return (taskData.taskCount == 0)
          ? EmptyTasks()
          : ListView.builder(
              itemCount: taskData.taskCount,
              itemBuilder: (context, index) {
                final task = taskData.tasks[index];
                return Dismissible(
                  key: ValueKey(task.id.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (DismissDirection direction) {
                    return taskData.removeTask(task);
                  },
                  background: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffffcfcf),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                        gradient: LinearGradient(stops: [
                          0.02,
                          0.02
                        ], colors: [
                          _colors[_randomIndex.nextInt(5)],
                          Colors.white
                        ]),
                      ),
                      child: ListTile(
                        title: Text(task.title,
                            style: Theme.of(context).textTheme.body1.copyWith(
                                  fontSize: 18,
                                  wordSpacing: 1.5,
                                  letterSpacing: 1.5,
                                  decoration: task.isDone == 1
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
                        subtitle: Text(
                          task.taskTime,
                          style: TextStyle(fontSize: 11),
                        ),
                        leading: Checkbox(
                          activeColor: Colors.lightBlueAccent,
                          value: task.isDone == 1,
                          onChanged: (_) {
                            return taskData.updateTask(task, index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              });
    });
  }
}
