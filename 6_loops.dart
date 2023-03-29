void main() {
  // for (int i = 0; i < 10; i++) {

  //   print("I Love Dart Programming");
  // }

  // int i = 1;
  // while (i <= 10) {
  //   print(i);
  //   i++;
  // }

  // i = 10;
  // do {
  //   print(i);
  //   i--;
  // } while (i >= 1);

  // for (int i = 10; i >= 1; i--) {
  //   if (i == 7) {
  //     break;
  //   }
  //   print(i);
  // }

  // for (int i = 10; i >= 1; i--) {
  //   if (i == 4) {
  //     continue;
  //   }
  //   print(i);
  // }
  // iloop:
  // for (var i = 0; i < 10; i++) {
  //   for (var j = 0; j < 10; j++) {
  //     print(j);
  //     if (j == 2) {
  //       break iloop ;
  //     }
  //   }
  // }

  //   int a = 12;
  // int b = 0;
  // int res;
  // try {
  //   res = a ~/ 10;
  // } on UnsupportedError {
  //   print('Cannot divide by zero');
  // } catch (ex) {
  //   print(ex);
  // } finally {
  //   print('Finally block always executed');
  // }

  for (int i = 1; i <= 9; i++) {
    for (int j = 1; j <= 10; j++) {
      print("$i * $j = ${i * j}");
    }
  }
}



// Exercise 2: Write a dart program to generate multiplication tables of 1-9.



















// Solution:
// void main() {
//   for (int i = 1; i <= 9; i++) {
//     for (int j = 1; j <= 10; j++) {
//       print("$i * $j = ${i * j}");
//     }
//   }
// }
