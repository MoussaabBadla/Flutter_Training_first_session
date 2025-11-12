//
void main() {
  Dog dog = Dog();

  Car car = Car("Red", 2002, name: "Toyota");
  final Anime naruto = Anime(
    name: "naruto",
    genre: "Action",
    studio: "Studio Pierrot",
  );
  naruto.name.capitalize();


  



  Box<int> intBox = Box<int>();
  intBox.value = 10;
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

class Anime {
  final String name;
  final String genre;
  final String studio;
  Anime({required this.name, required this.genre, this.studio = "Unknown"});

  factory Anime.fromMap(Map<String, String> data) {
    return Anime(
      name: data['name'] ?? 'Unknown',
      genre: data['genre'] ?? 'Unknown',
      studio: data['studio'] ?? 'Unknown',
    );
  }
}

class Box<T> {
  T? value;

  get setValue => value;
}

class Boxe {
  dynamic value;
}



extension StringExtension on String {
  // Add method to capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

