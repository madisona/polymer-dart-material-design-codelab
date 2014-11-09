import 'package:polymer/polymer.dart';

class Note extends Observable{
  @observable String body;
  @observable bool done;
  
  Note([this.body = "", this.done = false]);
}
