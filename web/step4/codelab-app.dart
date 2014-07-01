import 'package:polymer/polymer.dart';
import 'package:core_elements/core_drawer_panel.dart' show CoreDrawerPanel;
import 'dart:html';
import 'dart:js' show JsObject, context;



@CustomTag('codelab-app')
class CodelabApp extends PolymerElement {
  CodelabApp.created() : super.created() {}
  
  void toggleDrawer() {
    $['drawerPanel'].togglePanel();
  }        
}
