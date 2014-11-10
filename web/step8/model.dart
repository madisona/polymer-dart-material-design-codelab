import 'package:polymer/polymer.dart';

class Note extends Observable {
  @observable String body;
  @observable bool done;

  Note([this.body = "", this.done = false]);

  String toString() => "$body: $done";
  Map toJson() => {"body": body, "done": done};
  Note.fromJson(Map json) {
    body = json["body"];
    done = json["done"];
  }
}
