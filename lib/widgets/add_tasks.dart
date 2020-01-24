import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_to_do/models/task_data.dart';
import 'package:tasks_to_do/models/task_model.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String formattedTimeOfDay;
  String newTaskTitle;

//  TimeOfDay selectedTime;
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskData>(context, listen: false);
    return Container(
      color: Colors.lightBlueAccent,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add new task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 20.0,
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.body1,
                onChanged: (val) {
                  newTaskTitle = val;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  TimeOfDay selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    provider.setData(selectedTime);
                    final MaterialLocalizations localizations =
                        MaterialLocalizations.of(context);
                    formattedTimeOfDay =
                        localizations.formatTimeOfDay(selectedTime);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("choose Time"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        (formattedTimeOfDay == null)
                            ? Text(
                                "There is no time choosed",
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(formattedTimeOfDay),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              Provider.of<TaskData>(context).selected == false
                  ? SizedBox.shrink()
                  : Text(
                      "Please Select Data",
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(
                height: 12.0,
              ),
              FlatButton(
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  if (_key.currentState.validate() &&
                      formattedTimeOfDay != null) {
                    Task task = Task(
                        id: await provider.getNewId(),
                        title: newTaskTitle,
                        taskTime: formattedTimeOfDay);
                    provider.addTask(task);
                    Navigator.pop(context);
                  }else{
                    if (provider.dataSelected == null) {
                      provider.setSelect(true);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
