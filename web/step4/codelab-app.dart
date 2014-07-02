import 'package:polymer/polymer.dart';
import 'dart:html';


@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  CodelabApp.created() : super.created() {}
  
  void toggleDrawer() {
    $['drawerPanel'].togglePanel();
  }        
}
