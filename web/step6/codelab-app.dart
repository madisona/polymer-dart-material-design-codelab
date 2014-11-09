import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert' show JSON;

import 'model.dart' show Note;


const storageKey = "storage";


@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  @observable List data = toObservable([]);

  @observable String newNote;
  Storage localStorage = window.localStorage;

  CodelabApp.created() : super.created() {
    // adding a new note should be hidden by default.
    $['newNoteInput'].style.display = 'none';

    // populate data initially from the local storage.
    if (localStorage.containsKey(storageKey)) {
        for (var item in JSON.decode(localStorage[storageKey])) {
          data.add(new Note.fromJson(item));
        }
    }
  }

  void showNewNoteInput() {
    $['newNoteInput'].style.display = 'block';
  }

  void toggleDrawer() {
    $['drawerPanel'].togglePanel();
  }

  void dataChanged(val) {
    localStorage[storageKey] = JSON.encode(data);
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
