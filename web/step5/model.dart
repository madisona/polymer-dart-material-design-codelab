import 'package:polymer/polymer.dart';

class Note {
  @observable String body;
  @observable bool done;
  
  Note([this.body = "", this.done = false]);
}