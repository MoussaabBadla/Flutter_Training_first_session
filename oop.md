# Dart OOP, Generics, Mixins & Advanced Concepts

**Master Object-Oriented Programming in Dart**

---

## Table of Contents

1. [Classes and Objects](#classes-and-objects)
2. [Constructors](#constructors)
3. [Properties and Methods](#properties-and-methods)
4. [Inheritance](#inheritance)
5. [Abstract Classes](#abstract-classes)
6. [Interfaces](#interfaces)
7. [Mixins](#mixins)
8. [Enums](#enums)
9. [Generics](#generics)
10. [Extension Methods](#extension-methods)
11. [Practice Examples](#practice-examples)

---

## Classes and Objects

### What is a Class?

A **class** is a blueprint for creating objects. Think of it as a template.

**Real-world analogy:**
- Class = Car blueprint
- Object = Actual car (Toyota, BMW, etc.)

### Creating a Simple Class

```dart
// Define a class
class Person {
  String name = "";
  int age = 0;
  
  void introduce() {
    print("Hi, I'm $name and I'm $age years old");
  }
}

void main() {
  // Create object (instance) of Person
  Person person1 = Person();
  person1.name = "Moussaab";
  person1.age = 25;
  person1.introduce();  // Hi, I'm Moussaab and I'm 25 years old
  
  // Create another object
  Person person2 = Person();
  person2.name = "Ali";
  person2.age = 30;
  person2.introduce();  // Hi, I'm Ali and I'm 30 years old
}
```

### Class with Properties

```dart
class Car {
  // Properties (instance variables)
  String brand = "";
  String model = "";
  int year = 0;
  String color = "";
  
  // Method
  void displayInfo() {
    print("$year $brand $model - Color: $color");
  }
  
  void startEngine() {
    print("$brand $model engine started!");
  }
}

void main() {
  Car myCar = Car();
  myCar.brand = "Toyota";
  myCar.model = "Corolla";
  myCar.year = 2023;
  myCar.color = "White";
  
  myCar.displayInfo();     // 2023 Toyota Corolla - Color: White
  myCar.startEngine();     // Toyota Corolla engine started!
}
```

---

## Constructors

Constructors are special methods that run when creating an object.

### Default Constructor

```dart
class Student {
  String name;
  int age;
  
  // Constructor
  Student(this.name, this.age);
  
  void display() {
    print("Student: $name, Age: $age");
  }
}

void main() {
  // Create object using constructor
  Student student1 = Student("Ali", 20);
  student1.display();  // Student: Ali, Age: 20
  
  Student student2 = Student("Sara", 22);
  student2.display();  // Student: Sara, Age: 22
}
```

### Named Constructors

Create multiple ways to construct objects.

```dart
class Point {
  double x;
  double y;
  
  // Default constructor
  Point(this.x, this.y);
  
  // Named constructor - origin
  Point.origin() : x = 0, y = 0;
  
  // Named constructor - from coordinates
  Point.fromCoordinates(double x, double y) : this.x = x, this.y = y;
  
  void display() {
    print("Point($x, $y)");
  }
}

void main() {
  Point p1 = Point(10, 20);
  p1.display();  // Point(10.0, 20.0)
  
  Point p2 = Point.origin();
  p2.display();  // Point(0.0, 0.0)
  
  Point p3 = Point.fromCoordinates(5, 15);
  p3.display();  // Point(5.0, 15.0)
}
```

### Constructor with Optional Parameters

```dart
class User {
  String name;
  int age;
  String? email;  // Optional
  String? phone;  // Optional
  
  // Constructor with optional named parameters
  User({
    required this.name,
    required this.age,
    this.email,
    this.phone,
  });
  
  void display() {
    print("Name: $name");
    print("Age: $age");
    print("Email: ${email ?? 'Not provided'}");
    print("Phone: ${phone ?? 'Not provided'}");
  }
}

void main() {
  User user1 = User(name: "Moussaab", age: 25, email: "m@example.com");
  user1.display();
  
  print("");
  
  User user2 = User(name: "Ali", age: 30);
  user2.display();
}
```

### Constructor with Default Values

```dart
class Product {
  String name;
  double price;
  int quantity;
  
  Product({
    required this.name,
    this.price = 0.0,
    this.quantity = 1,
  });
  
  void display() {
    print("$name - \$${price} x $quantity");
  }
}

void main() {
  Product p1 = Product(name: "Laptop", price: 999.99, quantity: 2);
  p1.display();  // Laptop - $999.99 x 2
  
  Product p2 = Product(name: "Mouse");
  p2.display();  // Mouse - $0.0 x 1
}
```

### Constant Constructor

Create compile-time constant objects.

```dart
class ImmutablePoint {
  final double x;
  final double y;
  
  // Const constructor
  const ImmutablePoint(this.x, this.y);
}

void main() {
  const point1 = ImmutablePoint(10, 20);
  const point2 = ImmutablePoint(10, 20);
  
  print(identical(point1, point2));  // true - same object in memory
}
```

### Factory Constructor

Control how objects are created.

```dart
class Logger {
  String name;
  
  // Static instance
  static final Map<String, Logger> _cache = {};
  
  // Private constructor
  Logger._internal(this.name);
  
  // Factory constructor
  factory Logger(String name) {
    // Return cached instance if exists
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    }
    
    // Create new instance
    final logger = Logger._internal(name);
    _cache[name] = logger;
    return logger;
  }
  
  void log(String message) {
    print("[$name] $message");
  }
}

void main() {
  Logger logger1 = Logger("App");
  Logger logger2 = Logger("App");
  
  print(identical(logger1, logger2));  // true - same instance
  
  logger1.log("Hello");  // [App] Hello
  logger2.log("World");  // [App] World
}
```

---

## Properties and Methods

### Instance Variables and Methods

```dart
class BankAccount {
  // Instance variables
  String accountNumber;
  String ownerName;
  double balance;
  
  BankAccount(this.accountNumber, this.ownerName, this.balance);
  
  // Instance methods
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print("Deposited: \$$amount");
      print("New balance: \$$balance");
    }
  }
  
  void withdraw(double amount) {
    if (amount > 0 && amount <= balance) {
      balance -= amount;
      print("Withdrawn: \$$amount");
      print("New balance: \$$balance");
    } else {
      print("Insufficient funds");
    }
  }
  
  void displayInfo() {
    print("Account: $accountNumber");
    print("Owner: $ownerName");
    print("Balance: \$$balance");
  }
}

void main() {
  BankAccount account = BankAccount("123456", "Moussaab", 1000);
  
  account.displayInfo();
  print("");
  
  account.deposit(500);
  print("");
  
  account.withdraw(300);
  print("");
  
  account.displayInfo();
}
```

### Getters and Setters

Special methods to control access to properties.

```dart
class Rectangle {
  double _width;   // Private property (underscore)
  double _height;  // Private property
  
  Rectangle(this._width, this._height);
  
  // Getter - read property
  double get width => _width;
  double get height => _height;
  
  // Getter - calculated property
  double get area => _width * _height;
  double get perimeter => 2 * (_width + _height);
  
  // Setter - write property with validation
  set width(double value) {
    if (value > 0) {
      _width = value;
    }
  }
  
  set height(double value) {
    if (value > 0) {
      _height = value;
    }
  }
}

void main() {
  Rectangle rect = Rectangle(10, 5);
  
  // Using getters
  print("Width: ${rect.width}");
  print("Height: ${rect.height}");
  print("Area: ${rect.area}");
  print("Perimeter: ${rect.perimeter}");
  
  // Using setters
  rect.width = 15;
  rect.height = 8;
  
  print("\nAfter changes:");
  print("Area: ${rect.area}");
}
```

### Static Properties and Methods

Belong to the class, not instances.

```dart
class MathUtils {
  // Static constant
  static const double pi = 3.14159;
  
  // Static variable
  static int calculationCount = 0;
  
  // Static method
  static double circleArea(double radius) {
    calculationCount++;
    return pi * radius * radius;
  }
  
  static double circleCircumference(double radius) {
    calculationCount++;
    return 2 * pi * radius;
  }
}

void main() {
  // Access static members without creating object
  print("Pi: ${MathUtils.pi}");
  
  double area = MathUtils.circleArea(5);
  print("Circle area: $area");
  
  double circumference = MathUtils.circleCircumference(5);
  print("Circumference: $circumference");
  
  print("Total calculations: ${MathUtils.calculationCount}");
}
```

### Private Properties

Use underscore `_` to make properties private.

```dart
class Password {
  String _password;  // Private property
  
  Password(this._password);
  
  // Public method to check password
  bool verify(String input) {
    return input == _password;
  }
  
  // Public method to change password
  void change(String oldPassword, String newPassword) {
    if (verify(oldPassword)) {
      _password = newPassword;
      print("Password changed successfully");
    } else {
      print("Incorrect old password");
    }
  }
}

void main() {
  Password pwd = Password("secret123");
  
  // Cannot access _password directly (it's private)
  // print(pwd._password);  // ERROR
  
  print(pwd.verify("wrong"));      // false
  print(pwd.verify("secret123"));  // true
  
  pwd.change("secret123", "newpass456");
  print(pwd.verify("newpass456"));  // true
}
```

---

## Inheritance

Create new classes based on existing classes.

### Basic Inheritance

```dart
// Parent class (superclass)
class Animal {
  String name;
  int age;
  
  Animal(this.name, this.age);
  
  void eat() {
    print("$name is eating");
  }
  
  void sleep() {
    print("$name is sleeping");
  }
}

// Child class (subclass)
class Dog extends Animal {
  String breed;
  
  // Constructor
  Dog(String name, int age, this.breed) : super(name, age);
  
  // Additional method
  void bark() {
    print("$name is barking: Woof! Woof!");
  }
}

class Cat extends Animal {
  String color;
  
  Cat(String name, int age, this.color) : super(name, age);
  
  void meow() {
    print("$name is meowing: Meow!");
  }
}

void main() {
  Dog dog = Dog("Buddy", 3, "Golden Retriever");
  dog.eat();    // Inherited from Animal
  dog.sleep();  // Inherited from Animal
  dog.bark();   // Own method
  
  print("");
  
  Cat cat = Cat("Whiskers", 2, "White");
  cat.eat();    // Inherited from Animal
  cat.sleep();  // Inherited from Animal
  cat.meow();   // Own method
}
```

### Method Overriding

Change inherited methods in child class.

```dart
class Vehicle {
  String brand;
  
  Vehicle(this.brand);
  
  void start() {
    print("$brand vehicle is starting");
  }
  
  void stop() {
    print("$brand vehicle is stopping");
  }
}

class Car extends Vehicle {
  Car(String brand) : super(brand);
  
  // Override parent method
  @override
  void start() {
    print("$brand car: Turn key, engine roars!");
  }
}

class ElectricCar extends Vehicle {
  ElectricCar(String brand) : super(brand);
  
  @override
  void start() {
    print("$brand electric car: Silent startup!");
  }
}

void main() {
  Vehicle vehicle = Vehicle("Generic");
  vehicle.start();  // Generic vehicle is starting
  
  Car car = Car("Toyota");
  car.start();  // Toyota car: Turn key, engine roars!
  
  ElectricCar eCar = ElectricCar("Tesla");
  eCar.start();  // Tesla electric car: Silent startup!
}
```

### Using super

Call parent class methods and constructors.

```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print("Hi, I'm $name, $age years old");
  }
}

class Employee extends Person {
  String company;
  double salary;
  
  Employee(String name, int age, this.company, this.salary) 
      : super(name, age);
  
  @override
  void introduce() {
    // Call parent method
    super.introduce();
    // Add more info
    print("I work at $company");
    print("Salary: \$$salary");
  }
}

void main() {
  Employee emp = Employee("Moussaab", 25, "TechCorp", 5000);
  emp.introduce();
  // Hi, I'm Moussaab, 25 years old
  // I work at TechCorp
  // Salary: $5000
}
```

---

## Abstract Classes

Classes that cannot be instantiated. Used as templates.

### Basic Abstract Class

```dart
// Abstract class
abstract class Shape {
  // Abstract method (no implementation)
  double calculateArea();
  double calculatePerimeter();
  
  // Concrete method (has implementation)
  void display() {
    print("Area: ${calculateArea()}");
    print("Perimeter: ${calculatePerimeter()}");
  }
}

// Concrete class implementing abstract class
class Circle extends Shape {
  double radius;
  
  Circle(this.radius);
  
  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * radius;
  }
}

class Rectangle extends Shape {
  double width;
  double height;
  
  Rectangle(this.width, this.height);
  
  @override
  double calculateArea() {
    return width * height;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * (width + height);
  }
}

void main() {
  // Cannot create abstract class object
  // Shape shape = Shape();  // ERROR
  
  Circle circle = Circle(5);
  circle.display();
  
  print("");
  
  Rectangle rect = Rectangle(10, 5);
  rect.display();
}
```

### Abstract Class with Polymorphism

```dart
abstract class PaymentMethod {
  void processPayment(double amount);
  String getPaymentType();
}

class CreditCard extends PaymentMethod {
  String cardNumber;
  
  CreditCard(this.cardNumber);
  
  @override
  void processPayment(double amount) {
    print("Processing \$$amount via Credit Card");
    print("Card: $cardNumber");
  }
  
  @override
  String getPaymentType() => "Credit Card";
}

class PayPal extends PaymentMethod {
  String email;
  
  PayPal(this.email);
  
  @override
  void processPayment(double amount) {
    print("Processing \$$amount via PayPal");
    print("Email: $email");
  }
  
  @override
  String getPaymentType() => "PayPal";
}

class Cash extends PaymentMethod {
  @override
  void processPayment(double amount) {
    print("Received \$$amount in cash");
  }
  
  @override
  String getPaymentType() => "Cash";
}

void main() {
  // Polymorphism - different objects, same interface
  List<PaymentMethod> payments = [
    CreditCard("1234-5678-9012-3456"),
    PayPal("user@example.com"),
    Cash(),
  ];
  
  for (var payment in payments) {
    print("=== ${payment.getPaymentType()} ===");
    payment.processPayment(100);
    print("");
  }
}
```

---

## Interfaces

In Dart, every class is an interface. Use `implements` to implement interfaces.

### Implementing Interfaces

```dart
// Define interface (just a regular class)
class Flyable {
  void fly() {
    print("Flying...");
  }
}

class Swimmable {
  void swim() {
    print("Swimming...");
  }
}

// Implement multiple interfaces
class Duck implements Flyable, Swimmable {
  String name;
  
  Duck(this.name);
  
  // Must implement all methods from interfaces
  @override
  void fly() {
    print("$name is flying");
  }
  
  @override
  void swim() {
    print("$name is swimming");
  }
  
  void quack() {
    print("$name says: Quack!");
  }
}

class Fish implements Swimmable {
  String species;
  
  Fish(this.species);
  
  @override
  void swim() {
    print("$species is swimming underwater");
  }
}

void main() {
  Duck duck = Duck("Donald");
  duck.fly();
  duck.swim();
  duck.quack();
  
  print("");
  
  Fish fish = Fish("Goldfish");
  fish.swim();
}
```

### Abstract Class vs Interface

```dart
// Abstract class - can have implementation
abstract class Animal {
  String name;
  
  Animal(this.name);
  
  // Concrete method
  void eat() {
    print("$name is eating");
  }
  
  // Abstract method
  void makeSound();
}

// Interface - must implement everything
class Printable {
  void printInfo() {
    print("Printing info");
  }
}

class Dog extends Animal implements Printable {
  Dog(String name) : super(name);
  
  @override
  void makeSound() {
    print("$name barks");
  }
  
  // Must implement all interface methods
  @override
  void printInfo() {
    print("Dog: $name");
  }
}

void main() {
  Dog dog = Dog("Buddy");
  dog.eat();        // From Animal (inherited)
  dog.makeSound();  // Implemented
  dog.printInfo();  // From Printable (implemented)
}
```

---

## Mixins

Share code between classes without inheritance.

### Basic Mixin

```dart
// Define mixin
mixin Walker {
  void walk() {
    print("Walking...");
  }
}

mixin Swimmer {
  void swim() {
    print("Swimming...");
  }
}

mixin Flyer {
  void fly() {
    print("Flying...");
  }
}

// Use mixins with 'with' keyword
class Duck with Walker, Swimmer, Flyer {
  String name;
  
  Duck(this.name);
  
  void introduce() {
    print("I'm $name");
  }
}

class Penguin with Walker, Swimmer {
  String name;
  
  Penguin(this.name);
}

class Sparrow with Walker, Flyer {
  String name;
  
  Sparrow(this.name);
}

void main() {
  Duck duck = Duck("Donald");
  duck.introduce();
  duck.walk();
  duck.swim();
  duck.fly();
  
  print("");
  
  Penguin penguin = Penguin("Pingu");
  penguin.walk();
  penguin.swim();
  // penguin.fly();  // ERROR - Penguin doesn't have Flyer mixin
  
  print("");
  
  Sparrow sparrow = Sparrow("Jack");
  sparrow.walk();
  sparrow.fly();
  // sparrow.swim();  // ERROR - Sparrow doesn't have Swimmer mixin
}
```

### Mixin with Properties

```dart
mixin Timestamped {
  DateTime createdAt = DateTime.now();
  
  void printTimestamp() {
    print("Created at: $createdAt");
  }
}

mixin Identifiable {
  String id = "";
  
  void generateId() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

class User with Timestamped, Identifiable {
  String name;
  
  User(this.name) {
    generateId();
  }
  
  void display() {
    print("User: $name");
    print("ID: $id");
    printTimestamp();
  }
}

void main() {
  User user = User("Moussaab");
  user.display();
}
```

### Mixin with 'on' Constraint

Restrict which classes can use the mixin.

```dart
class Animal {
  String name;
  Animal(this.name);
}

// This mixin can only be used with Animal or its subclasses
mixin Carnivore on Animal {
  void hunt() {
    print("$name is hunting for meat");
  }
}

class Lion extends Animal with Carnivore {
  Lion(String name) : super(name);
}

// This works
class Tiger extends Animal with Carnivore {
  Tiger(String name) : super(name);
}

// This won't work - not extending Animal
// class Robot with Carnivore {  // ERROR
// }

void main() {
  Lion lion = Lion("Simba");
  lion.hunt();  // Simba is hunting for meat
  
  Tiger tiger = Tiger("Sher Khan");
  tiger.hunt();  // Sher Khan is hunting for meat
}
```

---

## Enums

Define a set of named constants.

### Basic Enum

```dart
// Define enum
enum Status {
  pending,
  approved,
  rejected,
  cancelled
}

enum PaymentStatus {
  unpaid,
  paid,
  refunded,
  failed
}

void main() {
  Status orderStatus = Status.pending;
  
  print("Order status: $orderStatus");  // Order status: Status.pending
  print("Status name: ${orderStatus.name}");  // Status name: pending
  
  // Use in switch
  switch (orderStatus) {
    case Status.pending:
      print("Waiting for approval");
      break;
    case Status.approved:
      print("Order approved");
      break;
    case Status.rejected:
      print("Order rejected");
      break;
    case Status.cancelled:
      print("Order cancelled");
      break;
  }
  
  // Get all values
  print("\nAll statuses:");
  for (var status in Status.values) {
    print("- ${status.name}");
  }
}
```

### Enhanced Enums (Dart 2.17+)

Enums with properties and methods.

```dart
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6);
  
  // Properties
  final double mass;
  final double radius;
  
  // Constructor
  const Planet(this.mass, this.radius);
  
  // Method
  double get surfaceGravity {
    const G = 6.67430e-11;
    return G * mass / (radius * radius);
  }
}

void main() {
  Planet earth = Planet.earth;
  
  print("Planet: ${earth.name}");
  print("Mass: ${earth.mass} kg");
  print("Radius: ${earth.radius} m");
  print("Surface gravity: ${earth.surfaceGravity.toStringAsFixed(2)} m/s²");
  
  print("\nAll planets:");
  for (var planet in Planet.values) {
    print("${planet.name}: ${planet.surfaceGravity.toStringAsFixed(2)} m/s²");
  }
}
```

### Enum in Classes

```dart
enum UserRole {
  admin,
  moderator,
  user,
  guest
}

class User {
  String name;
  UserRole role;
  
  User(this.name, this.role);
  
  bool canEdit() {
    return role == UserRole.admin || role == UserRole.moderator;
  }
  
  bool canDelete() {
    return role == UserRole.admin;
  }
  
  void display() {
    print("User: $name");
    print("Role: ${role.name}");
    print("Can edit: ${canEdit()}");
    print("Can delete: ${canDelete()}");
  }
}

void main() {
  User admin = User("Moussaab", UserRole.admin);
  admin.display();
  
  print("");
  
  User regularUser = User("Ali", UserRole.user);
  regularUser.display();
}
```

---

## Generics

Write reusable code that works with different types.

### Generic Class

```dart
// Generic class with type parameter T
class Box<T> {
  T value;
  
  Box(this.value);
  
  void display() {
    print("Box contains: $value (${value.runtimeType})");
  }
}

void main() {
  // Box of int
  Box<int> intBox = Box<int>(123);
  intBox.display();  // Box contains: 123 (int)
  
  // Box of String
  Box<String> stringBox = Box<String>("Hello");
  stringBox.display();  // Box contains: Hello (String)
  
  // Box of List
  Box<List<int>> listBox = Box<List<int>>([1, 2, 3]);
  listBox.display();  // Box contains: [1, 2, 3] (List<int>)
  
  // Type inference
  var autoBox = Box(3.14);  // Dart infers Box<double>
  autoBox.display();  // Box contains: 3.14 (double)
}
```

### Generic Methods

```dart
// Generic function
T getFirst<T>(List<T> items) {
  return items.first;
}

void printItems<T>(List<T> items) {
  for (var item in items) {
    print("- $item");
  }
}

// Swap two values
(T, T) swap<T>(T first, T second) {
  return (second, first);
}

void main() {
  // Use with different types
  List<int> numbers = [1, 2, 3, 4, 5];
  print("First number: ${getFirst(numbers)}");
  
  List<String> names = ["Ali", "Sara", "Ahmed"];
  print("First name: ${getFirst(names)}");
  
  print("\nNumbers:");
  printItems(numbers);
  
  print("\nNames:");
  printItems(names);
  
  // Swap
  var (a, b) = swap(10, 20);
  print("\nAfter swap: $a, $b");
  
  var (x, y) = swap("Hello", "World");
  print("After swap: $x, $y");
}
```

### Generic Collection Class

```dart
class Stack<T> {
  final List<T> _items = [];
  
  void push(T item) {
    _items.add(item);
    print("Pushed: $item");
  }
  
  T? pop() {
    if (_items.isEmpty) {
      print("Stack is empty");
      return null;
    }
    T item = _items.removeLast();
    print("Popped: $item");
    return item;
  }
  
  T? peek() {
    if (_items.isEmpty) return null;
    return _items.last;
  }
  
  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;
  
  void display() {
    print("Stack: $_items");
  }
}

void main() {
  // Stack of integers
  Stack<int> intStack = Stack<int>();
  intStack.push(10);
  intStack.push(20);
  intStack.push(30);
  intStack.display();
  
  intStack.pop();
  intStack.display();
  
  print("\n");
  
  // Stack of strings
  Stack<String> stringStack = Stack<String>();
  stringStack.push("First");
  stringStack.push("Second");
  stringStack.push("Third");
  stringStack.display();
  
  print("Top item: ${stringStack.peek()}");
}
```

### Type Constraints

Limit what types can be used with generics.

```dart
// Only classes extending num (int, double)
class NumberBox<T extends num> {
  T value;
  
  NumberBox(this.value);
  
  T add(T other) {
    // This works because T is guaranteed to be num
    return (value + other) as T;
  }
  
  void display() {
    print("Value: $value");
  }
}

void main() {
  NumberBox<int> intBox = NumberBox<int>(10);
  intBox.display();
  print("After adding 5: ${intBox.add(5)}");
  
  NumberBox<double> doubleBox = NumberBox<double>(3.14);
  doubleBox.display();
  print("After adding 2.86: ${doubleBox.add(2.86)}");
  
  // This won't work - String is not a num
  // NumberBox<String> stringBox = NumberBox<String>("Hello");  // ERROR
}
```

---

# Dart OOP - Extension Methods & Practice Examples

## Extension Methods

Add functionality to existing classes without modifying them.

### Basic Extension

```dart
// Extend String class
extension StringExtension on String {
  // Add method to capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
  
  // Check if string is email
  bool get isEmail {
    return contains('@') && contains('.');
  }
  
  // Reverse string
  String get reversed {
    return split('').reversed.join('');
  }
}

void main() {
  String name = "moussaab";
  print(name.capitalize());  // Moussaab
  
  String email = "test@example.com";
  print(email.isEmail);  // true
  
  String text = "Hello";
  print(text.reversed);  // olleH
}
```

### Extension on List

```dart
extension ListExtension<T> on List<T> {
  // Get random element
  T get random {
    return this[(length * 0.5).toInt()];
  }
  
  // Check if list has duplicates
  bool get hasDuplicates {
    return length != toSet().length;
  }
  
  // Get second element safely
  T? get secondOrNull {
    return length >= 2 ? this[1] : null;
  }
}

void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  print("Random: ${numbers.random}");
  print("Has duplicates: ${numbers.hasDuplicates}");
  print("Second: ${numbers.secondOrNull}");
  
  List<int> duplicates = [1, 2, 2, 3];
  print("Has duplicates: ${duplicates.hasDuplicates}");  // true
}
```

### Extension on int

```dart
extension IntExtension on int {
  // Check if even
  bool get isEven => this % 2 == 0;
  
  // Check if odd
  bool get isOdd => this % 2 != 0;
  
  // Times method (like Ruby)
  void times(void Function(int) action) {
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }
  
  // To currency string
  String get toCurrency => '\$$this.00';
}

void main() {
  print(5.isEven);  // false
  print(4.isEven);  // true
  
  3.times((i) => print('Hello $i'));
  // Hello 0
  // Hello 1
  // Hello 2
  
  print(100.toCurrency);  // $100.00
}
```

### Extension on DateTime

```dart
extension DateTimeExtension on DateTime {
  // Check if today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  // Format as string
  String get formatted {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
  
  // Days until this date
  int daysUntil(DateTime other) {
    return other.difference(this).inDays;
  }
}

void main() {
  DateTime today = DateTime.now();
  print(today.isToday);  // true
  print(today.formatted);  // 2024-11-12
  
  DateTime future = DateTime.now().add(Duration(days: 10));
  print(today.daysUntil(future));  // 10
}
```

---

## Practice Examples

### Example 1: Library System

```dart
// Book class
class Book {
  String title;
  String author;
  String isbn;
  bool isAvailable;
  
  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.isAvailable = true,
  });
  
  void display() {
    print('Title: $title');
    print('Author: $author');
    print('ISBN: $isbn');
    print('Available: ${isAvailable ? "Yes" : "No"}');
  }
}

// Member class
class Member {
  String name;
  String memberId;
  List<Book> borrowedBooks = [];
  
  Member(this.name, this.memberId);
  
  void borrowBook(Book book) {
    if (book.isAvailable) {
      book.isAvailable = false;
      borrowedBooks.add(book);
      print('$name borrowed: ${book.title}');
    } else {
      print('Book not available');
    }
  }
  
  void returnBook(Book book) {
    if (borrowedBooks.contains(book)) {
      book.isAvailable = true;
      borrowedBooks.remove(book);
      print('$name returned: ${book.title}');
    }
  }
  
  void showBorrowedBooks() {
    print('\n$name\'s borrowed books:');
    if (borrowedBooks.isEmpty) {
      print('No books borrowed');
    } else {
      for (var book in borrowedBooks) {
        print('- ${book.title}');
      }
    }
  }
}

void main() {
  // Create books
  Book book1 = Book(
    title: 'Dart Programming',
    author: 'John Doe',
    isbn: '123-456-789',
  );
  
  Book book2 = Book(
    title: 'Flutter Development',
    author: 'Jane Smith',
    isbn: '987-654-321',
  );
  
  // Create member
  Member member = Member('Moussaab', 'M001');
  
  // Borrow books
  member.borrowBook(book1);
  member.borrowBook(book2);
  
  // Show borrowed books
  member.showBorrowedBooks();
  
  // Return a book
  member.returnBook(book1);
  
  // Show borrowed books again
  member.showBorrowedBooks();
}
```

### Example 2: Shopping Cart with Generics

```dart
// Product class
class Product {
  String name;
  double price;
  int quantity;
  
  Product(this.name, this.price, {this.quantity = 1});
  
  double get totalPrice => price * quantity;
  
  @override
  String toString() {
    return '$name x$quantity - \$${totalPrice.toStringAsFixed(2)}';
  }
}

// Generic Cart class
class Cart<T extends Product> {
  List<T> items = [];
  
  void addItem(T item) {
    items.add(item);
    print('Added: ${item.name}');
  }
  
  void removeItem(T item) {
    items.remove(item);
    print('Removed: ${item.name}');
  }
  
  double get total {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }
  
  void displayCart() {
    print('\n=== Shopping Cart ===');
    if (items.isEmpty) {
      print('Cart is empty');
    } else {
      for (var item in items) {
        print(item);
      }
      print('---');
      print('Total: \$${total.toStringAsFixed(2)}');
    }
  }
}

void main() {
  Cart<Product> cart = Cart();
  
  cart.addItem(Product('Laptop', 999.99, quantity: 1));
  cart.addItem(Product('Mouse', 29.99, quantity: 2));
  cart.addItem(Product('Keyboard', 79.99, quantity: 1));
  
  cart.displayCart();
}
```

### Example 3: Animal Hierarchy with Mixins

```dart
// Base class
abstract class Animal {
  String name;
  int age;
  
  Animal(this.name, this.age);
  
  void eat() => print('$name is eating');
  void sleep() => print('$name is sleeping');
  
  // Abstract method
  void makeSound();
}

// Mixins
mixin Walker {
  void walk() => print('Walking on ground');
}

mixin Swimmer {
  void swim() => print('Swimming in water');
}

mixin Flyer {
  void fly() => print('Flying in sky');
}

// Concrete classes
class Dog extends Animal with Walker {
  String breed;
  
  Dog(String name, int age, this.breed) : super(name, age);
  
  @override
  void makeSound() => print('$name: Woof! Woof!');
}

class Fish extends Animal with Swimmer {
  String species;
  
  Fish(String name, int age, this.species) : super(name, age);
  
  @override
  void makeSound() => print('$name: Blub blub');
}

class Duck extends Animal with Walker, Swimmer, Flyer {
  Duck(String name, int age) : super(name, age);
  
  @override
  void makeSound() => print('$name: Quack!');
}

void main() {
  print('=== Dog ===');
  Dog dog = Dog('Buddy', 3, 'Golden Retriever');
  dog.makeSound();
  dog.walk();
  dog.eat();
  
  print('\n=== Fish ===');
  Fish fish = Fish('Nemo', 1, 'Clownfish');
  fish.makeSound();
  fish.swim();
  
  print('\n=== Duck ===');
  Duck duck = Duck('Donald', 2);
  duck.makeSound();
  duck.walk();
  duck.swim();
  duck.fly();
}
```

### Example 4: Bank Account System

```dart
// Abstract account class
abstract class BankAccount {
  String accountNumber;
  String ownerName;
  double balance;
  
  BankAccount(this.accountNumber, this.ownerName, this.balance);
  
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited: \$$amount');
    }
  }
  
  // Abstract method
  bool withdraw(double amount);
  
  void displayBalance() {
    print('Balance: \$${balance.toStringAsFixed(2)}');
  }
}

// Savings account - has minimum balance
class SavingsAccount extends BankAccount {
  double minimumBalance = 100;
  
  SavingsAccount(String accountNumber, String ownerName, double balance)
      : super(accountNumber, ownerName, balance);
  
  @override
  bool withdraw(double amount) {
    if (amount > 0 && (balance - amount) >= minimumBalance) {
      balance -= amount;
      print('Withdrawn: \$$amount');
      return true;
    } else {
      print('Cannot withdraw - minimum balance required');
      return false;
    }
  }
}

// Checking account - can go negative up to limit
class CheckingAccount extends BankAccount {
  double overdraftLimit = 500;
  
  CheckingAccount(String accountNumber, String ownerName, double balance)
      : super(accountNumber, ownerName, balance);
  
  @override
  bool withdraw(double amount) {
    if (amount > 0 && (balance - amount) >= -overdraftLimit) {
      balance -= amount;
      print('Withdrawn: \$$amount');
      return true;
    } else {
      print('Cannot withdraw - overdraft limit exceeded');
      return false;
    }
  }
}

void main() {
  print('=== Savings Account ===');
  SavingsAccount savings = SavingsAccount('SAV001', 'Moussaab', 1000);
  savings.displayBalance();
  savings.deposit(500);
  savings.withdraw(1000);  // Can't - would go below minimum
  savings.withdraw(300);   // OK
  savings.displayBalance();
  
  print('\n=== Checking Account ===');
  CheckingAccount checking = CheckingAccount('CHK001', 'Ali', 500);
  checking.displayBalance();
  checking.withdraw(800);  // OK - can go negative
  checking.displayBalance();
}
```

---

## Key Takeaways

### Classes & Objects
- Classes are blueprints, objects are instances
- Use constructors to initialize objects
- Private members use underscore `_`

### Inheritance
- `extends` for single inheritance
- `super` to access parent class
- `@override` to override methods

### Abstract Classes
- Cannot be instantiated
- Define contract for subclasses
- Can have both abstract and concrete methods

### Interfaces
- Every class is an interface
- `implements` to implement interface
- Must implement all methods

### Mixins
- Share code without inheritance
- Use `with` keyword
- Can use multiple mixins
- Use `on` to constrain mixin usage

### Generics
- Write type-safe reusable code
- Use `<T>` for type parameters
- Can constrain types with `extends`

### Extensions
- Add methods to existing classes
- Don't modify original class
- Great for utility functions

### Best Practices
1. Keep classes focused (Single Responsibility)
2. Use composition over inheritance when possible
3. Make fields private, expose with getters/setters
4. Use abstract classes for shared behavior
5. Use mixins for cross-cutting concerns
6. Prefer generics for type-safe collections
7. Use extensions for utility methods