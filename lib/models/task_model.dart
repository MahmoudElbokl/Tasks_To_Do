class Task {
  int id;
  String title;
  int isDone;
  String taskTime;

  Task({this.id, this.title, this.isDone = 0, this.taskTime});

  toggleDone() {
    if (isDone == 1) {
      isDone = 0;
    } else {
      isDone = 1;
    }
  }

  Task.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.isDone = map["isdone"];
    this.taskTime = map["tasktime"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["title"] = this.title;
    map["isdone"] = this.isDone;
    map["tasktime"] = this.taskTime;
    return map;
  }

  Task.fromObj(dynamic obj) {
    this.id = obj["id"];
    this.title = obj["title"];
    this.isDone = obj["isdone"];
    this.taskTime = obj["tasktime"];
  }
}
