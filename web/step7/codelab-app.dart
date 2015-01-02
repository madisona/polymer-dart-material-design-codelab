import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert' show JSON;


const storageKey = "storage";


@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  @observable List data = toObservable([]);

  @observable String newNote;
  @observable bool fadeSelected = true;
  @observable var fontSize = '14';
  Storage localStorage = window.localStorage;

  CodelabApp.created() : super.created() {
    // adding a new note should be hidden by default.
    $['newNoteInput'].style.display = 'none';

    // populate data initially from the local storage.
    if (localStorage.containsKey(storageKey)) {
        for (var item in JSON.decode(localStorage[storageKey])) {
          data.add(toObservable(item));
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

  void fontSizeChanged() {
      var cards = this.shadowRoot.querySelectorAll('.card');
      for (var card in cards) {
        card.style.fontSize = fontSize.toString() + "px";
      }
  }

  void add(Event e, Object detail, Node sender) {
    e.preventDefault();;
    if (sender.value != null) {
      data.insert(0, toObservable({"body": sender.value, "done": false}));
      $['newNoteInput'].style.display = 'none';
      $['newNoteInput'].value = null;
    }
  }

  void delete() {
    data.removeWhere((note) => note['done'] == true);
  }

  void reset() {
    fadeSelected = true;
    fontSize = "14";
    $['toast'].show();
  }
}
