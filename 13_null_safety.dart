import 'dart:io';

void main() {
  String? name = "john";
  name = null;
  String? userAnswer = stdin.readLineSync();
  if (userAnswer != null) {
  } else {
    print("invalid input");
  }

}
