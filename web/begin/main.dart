import 'dart:html';

void main() {
 Element element = querySelector(".content");
 
 for (var i = 0; i < 200; i++) {
   element.innerHtml += "Hello, world!<br />";
 }
}