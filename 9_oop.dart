//
void main() {
  Dog dog = Dog();

  Car car = Car("Red", 2002, name: "Toyota");
}

class Animal {
  String? name;
  int? numberOfLegs;
  int? lifeSpan;

  void display() {
    print("Animal name: $name.");
    print("Number of Legs: $numberOfLegs.");
    print("Life Span: $lifeSpan.");
  }

  void eat() {
    print("Animal is eating");
  }
}

class Person {
  String? name;
  String? phone;
  bool? isMarried;
  int? age;
  Person(this.age, this.name);

  void displayInfo() {
    print("Person name: $name.");
    print("Phone number: $phone.");
    print("Married: $isMarried.");
    print("Age: $age.");
  }
}

class Area {
  double? length;
  double? breadth;

  double calculateArea() {
    return length! * breadth!;
  }
}

class Student extends Person {
  // Fields

  String? schoolName;
  String? schoolAddress;

  Student(this.schoolName, super.age, super.name);

  // Method
  void displaySchoolInfo() {
    print("School Name: $schoolName");
    print("School Address: $schoolAddress");
  }
}

// class Car {
//   String color;
//   int year;
//   Car(this.color, this.year);

//   void start() {
//     print("Car started");
//   }
// }

// class Toyota extends Car {
//   String model;
//   int prize;
//   Toyota(this.model, this.prize, String color, int year) : super(color, year);

//   void showDetails() {
//     print("Model: $model");
//     print("Prize: $prize");
//   }
// }

class Dog extends Animal {
  @override
  void eat() {
    super.eat();
    print("Dog is eating");
  }
}

// abstract class Vehicle {
//   // Abstract method
//   void start();
//   // Abstract method
//   void stop();
// }

// class Car extends Vehicle {
//   // Implementation of start()

//   @override
//   void start() {
//     print('Car started');
//   }

//   // Implementation of stop()
//   @override
//   void stop() {
//     print('Car stopped');
//   }
// }

// class Bike extends Vehicle {
//   // Implementation of start()
//   @override
//   void start() {
//     print('Bike started');
//   }

//   // Implementation of stop()
//   @override
//   void stop() {
//     print('Bike stopped');
//   }
// }

abstract class Vehicle {
  void start();
  void stop();
  const Vehicle(); // constructor
}

// implements interface
class Car implements Vehicle {
  static const int wheels = 4; // static variable
  final String color; // final variable
  final String? name;
  final int year; // final variable
  const Car(this.color, this.year, {required this.name}); // constructor

  @override
  void start() {}

  @override
  void stop() {}
}

// void main() {
//   var car = Car();
//   car.start();
//   car.stop();
// }





// mixin CanFly {
//   void fly() {
//     print('I can fly');
//   }
// }

// mixin CanWalk {
//   void walk() {
//     print('I can walk');
//   }
// }

// class Bird with CanFly, CanWalk {
 
// }
