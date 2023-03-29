void main() {
  // var firstName = "Moussaab";
  // String lastName = "Badla";
  // print("Full name is $firstName $lastName");
  int num1 = 10; //declaring number1
  int num2 = 3; //declaring number2

// Calculation
  int sum = num1 + num2;
  int diff = num1 - num2;
  int mul = num1 * num2;
  double div =
      num1 / num2; // It is double because it outputs number with decimal.

// // displaying the output
  // print("The sum is $sum");
  // print("The diff is $diff");
  // print("The mul is $mul");
  // print("The div is $div");

//   String name = "Mossaab";
//   String address = "Batna";
//   num age = 20; // used to store any types of numbers
//   num height = 5.9;
//   bool isMarried = false;

// // printing variables value
//   print("Name is $name");
//   print("Address is $address");
//   print("Age is $age");
//   print("Height is $height");
//   print("Married Status is $isMarried");

  String multiLineText = '''
This is Multi Line Text
with 3 single quote
I am also writing here.
''';

  String myString = '''
 azea , 
 azeaz, 
''';

// Multi Line Using Double Quotes
  String otherMultiLineText = """
This is Multi Line Text 
with 3 double quote 
I am also writing here.
""";

// // Printing Information
  print("Multiline text is $multiLineText");
//   print("Other multiline text is $otherMultiLineText");

  print("I am from \nAlgeria.");
  print("I am from \tAlgeria.");
}
