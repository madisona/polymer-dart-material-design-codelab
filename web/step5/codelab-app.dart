import 'package:polymer/polymer.dart';
import 'dart:html';

import 'model.dart' show Note;


@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  @observable List data = toObservable([]);

  @observable String newNote;
  
  CodelabApp.created() : super.created() {
    // adding a new note should be hidden by default.
    $['newNoteInput'].style.display = 'none';
  }
  
  void showNewNoteInput() {
    $['newNoteInput'].style.display = 'block';
  }
  
  void toggleDrawer() {
    $['drawerPanel'].togglePanel();
  }
  
  void add(Event e, Object detail, Node sender) {
    e.preventDefault();;
    if (sender.value != null) {
      data.insert(0, new Note(sender.value, false));
      $['newNoteInput'].style.display = 'none';
      $['newNoteInput'].value = null;
    }
  }
}
