import 'package:polymer/polymer.dart';
import 'package:collection/equality.dart' show DeepCollectionEquality;
import 'dart:html';
import 'dart:convert' show JSON;
import 'package:firebase/firebase.dart' show Firebase, Query, Event;


const storageKey = "storagetest";
const FB_URL = "https://<your-firebase>.firebaseio.com/";
Function deepEq = const DeepCollectionEquality().equals;

@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  @observable List data = toObservable([]);

  @observable String newNote;
  @observable bool fadeSelected = true;
  @observable var fontSize = '14';
  Firebase fb;

  CodelabApp.created() : super.created() {
    // adding a new note should be hidden by default.
    $['newNoteInput'].style.display = 'none';

    fb = new Firebase(FB_URL);
    fb.child(storageKey).onValue.listen(updateDataItem);
  }

  void updateDataItem(Event e) {
    // Received data update from Firebase. We only really want to change
    // data here if it is different than what we've already got.  We have a loop
    // where we update data, it tells firebase, firebase tells the app, app updates, tells fb again, etc...
    var value = e.snapshot.val();

    if (value != null && !deepEq(value, data)) {
      var notes = [];
      for (var item in JSON.decode(value)) {
        notes.add(toObservable(item));
      }
      data.replaceRange(0, data.length, notes);
    }
  }

  void showNewNoteInput() {
    $['newNoteInput'].style.display = 'block';
  }

  void toggleDrawer() {
    $['drawerPanel'].togglePanel();
  }

  void dataChanged(val) {
    fb.set({storageKey: JSON.encode(data)});
  }

  void fontSizeChanged() {
      var cards = this.shadowRoot.querySelectorAll('.card');
      for (var card in cards) {
        card.style.fontSize = fontSize.toString() + "px";
      }
  }

  void add(Event e, Object detail, Node sender) {
    e.preventDefault();;
    if (newNote != null) {
      data.insert(0, toObservable({"body": sender.value, "done": false}));
      $['newNoteInput'].style.display = 'none';
      newNote = null;
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
