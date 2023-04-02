void main() async {
  Stream<String> username = getUserName();
  username.listen((event) {
    print(event);
  });
}

// Future<String> getUserName() {
//   return Future.value('Mark');
// }

void getData() async {
  String data = await middleFunction();
  print(data);
}

Future<String> middleFunction() {
  return Future.delayed(Duration(seconds: 5), () => "Hello");
}

Stream<String> getUserName() async* {
  yield 'Mark';
  yield 'John';
  yield 'Smith';
}

Future<void> getNumbers() async {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 3), () => print(i));
  }
}
