enum days { Sunday, Monday, Tuesday, Wednesday, Thrusday, Friday, Saturday }

// void main() {
//   var today = days.Friday;
//   switch (today) {
//     case days.Sunday:
//       print("Today is Sunday.");
//       break;
//     case days.Monday:
//       print("Today is Monday.");
//       break;
//     case days.Tuesday:
//       print("Today is Tuesday.");
//       break;
//     case days.Wednesday:
//       print("Today is Wednesday.");
//       break;
//     case days.Thrusday:
//       print("Today is Thursday.");
//       break;
//     case days.Friday:
//       print("Today is Friday.");
//       break;
//     case days.Saturday:
//       print("Today is Saturday.");
//       break;
//   }
// }

enum Gender { Male, Female }

class Person {
  // Properties
  String? firstName;
  String? lastName;
  Gender? gender;

  // Constructor
  Person(this.firstName, this.lastName, this.gender);

  // display() method
  void display() {
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Gender: $gender");
  }
}

void main() {
  Person p1 = Person("John", "Doe", Gender.Male);
  p1.display();

  Person p2 = Person("Menuka", "Sharma", Gender.Female);
  p2.display();
}
