import 'dart:async';

StreamController<dynamic> controller = StreamController<dynamic>.broadcast();

Stream stream = controller.stream;
void main() {
  var streamSubscription = stream.listen((event) {
    print("from listener one : $event");
  });
  var streamSubscription2 = stream.listen((event) {
    print("from listener two : $event");
  });

  controller.add("Data!");
  controller.add("Data!");
  controller.add("Data!");
  controller.add("Data!");
}
