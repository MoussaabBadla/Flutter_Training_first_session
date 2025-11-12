# Dart Variables Complete Guide

**Understanding every way to store data in Dart**

---

## Table of Contents

1. [Introduction](#introduction)
2. [var vs Type Declaration](#var-vs-type-declaration)
3. [dynamic - The Wild Card](#dynamic---the-wild-card)
4. [final vs const](#final-vs-const)
5. [All Dart Data Types](#all-dart-data-types)
6. [Records (Tuples)](#records-tuples)
7. [String Special Features](#string-special-features)
8. [Practice Code Examples](#practice-code-examples)

---

## Introduction

In Dart, you can store data in variables in many different ways. Each way has a purpose. This guide explains **all of them** in simple terms.

**Three big questions:**
1. **How to declare?** (`var`, `Type`, `dynamic`)
2. **Can it change?** (`final`, `const`, or normal)
3. **What type?** (int, String, bool, etc.)

---

## var vs Type Declaration

### Using `var` (Type Inference)

When you use `var`, Dart **guesses** the type automatically.

```dart
void main() {
  var firstName = "Moussaab";  // Dart knows this is a String
  var age = 25;                // Dart knows this is an int
  var height = 5.9;            // Dart knows this is a double
  var isStudent = true;        // Dart knows this is a bool
  
  print(firstName.runtimeType); // String
  print(age.runtimeType);       // int
}
```

**Rules:**
- Dart decides the type based on the first value
- You **cannot** change the type later
- Once a String, always a String

```dart
var name = "Ali";
name = "Ahmed";  // ✅ OK - still a String
name = 123;      // ❌ ERROR - cannot change String to int
```

### Using Type Declaration

You tell Dart exactly what type you want.

```dart
void main() {
  String firstName = "Moussaab";
  int age = 25;
  double height = 5.9;
  bool isStudent = true;
  
  print("Name: $firstName");
  print("Age: $age");
}
```

**When to use which?**

| Use `var` | Use Type Declaration |
|-----------|---------------------|
| Quick coding | When type is important |
| Type is obvious | For documentation |
| Less typing | In function parameters |
| Local variables | Class properties |

**Best practice:** Use what makes your code **clearer**.

---

## dynamic - The Wild Card

`dynamic` is special - the variable can change type **any time**.

```dart
void main() {
  dynamic value = "Hello";  // String
  print(value);             // Hello
  
  value = 123;              // Now it's int
  print(value);             // 123
  
  value = true;             // Now it's bool
  print(value);             // true
  
  value = [1, 2, 3];        // Now it's List
  print(value);             // [1, 2, 3]
}
```

### var vs dynamic - The Difference

```dart
void main() {
  // var - type is locked after first assignment
  var name = "Ali";
  name = "Ahmed";   // ✅ OK
  name = 123;       // ❌ ERROR
  
  // dynamic - type can change any time
  dynamic value = "Ali";
  value = "Ahmed";  // ✅ OK
  value = 123;      // ✅ OK - dynamic allows this
}
```

### When to Use dynamic?

**Use dynamic when:**
- Working with JSON data (from APIs)
- You really don't know the type ahead of time
- Dealing with external data

**⚠️ Warning:** `dynamic` is dangerous! No type checking means more bugs.

```dart
void main() {
  dynamic data = "Hello";
  print(data.length);    // 5 - works because String has length
  
  data = 123;
  print(data.length);    // ❌ CRASH at runtime - int has no length
}
```

**Rule:** Avoid `dynamic` unless you have a good reason.

---

## final vs const

Both make variables **unchangeable**, but they work differently.

### final - Runtime Constant

`final` means: **Set once, never change**. The value can be determined while the program runs.

```dart
void main() {
  final String name = "Moussaab";
  final int age = 25;
  
  // name = "Ahmed";  // ❌ ERROR - cannot change final variable
  
  // final with var
  final city = "Algiers";  // Type inferred
  
  // final with runtime values
  final currentTime = DateTime.now();  // ✅ OK - calculated at runtime
  final userInput = readUserInput();   // ✅ OK - gets value when running
  
  print(name);
  print(currentTime);
}
```

**Think of final as:** "Set once when the program runs, then lock it."

### const - Compile-Time Constant

`const` means: **Known before the program runs**. The value must be decided when you write the code.

```dart
void main() {
  const String country = "Algeria";
  const int maxUsers = 100;
  const double pi = 3.14159;
  
  // country = "Morocco";  // ❌ ERROR - cannot change const
  
  // const with var
  const appName = "MyApp";  // Type inferred
  
  // const must be compile-time constant
  // const time = DateTime.now();  // ❌ ERROR - not known at compile time
  
  print(country);
}
```

**Think of const as:** "Value is known when you write the code."

### final vs const - The Big Difference

```dart
void main() {
  // final - can use runtime values
  final currentTime = DateTime.now();     // ✅ Works
  final random = Random().nextInt(100);   // ✅ Works
  
  // const - must be compile-time value
  // const currentTime = DateTime.now();  // ❌ ERROR
  // const random = Random().nextInt(100); // ❌ ERROR
  
  const maxItems = 50;                    // ✅ Works - value is in code
  const appVersion = "1.0.0";             // ✅ Works - value is in code
}
```

### Memory Difference

```dart
void main() {
  // const - same object in memory
  const list1 = [1, 2, 3];
  const list2 = [1, 2, 3];
  print(identical(list1, list2));  // true - same object!
  
  // final - different objects in memory
  final list3 = [1, 2, 3];
  final list4 = [1, 2, 3];
  print(identical(list3, list4));  // false - different objects
}
```

### Quick Comparison

| Feature | **final** | **const** |
|---------|-----------|-----------|
| **When set** | At runtime | At compile-time |
| **Can use DateTime.now()** | ✅ Yes | ❌ No |
| **Can use user input** | ✅ Yes | ❌ No |
| **Memory efficient** | Normal | Very efficient |
| **In classes** | Instance variables | Static only |
| **Best for** | Runtime constants | Compile-time constants |

### When to Use Which?

**Use `final` when:**
- Value comes from calculation
- Value comes from user
- Value comes from API
- Most cases!

**Use `const` when:**
- Value never changes (like pi = 3.14)
- Configuration values
- App settings
- Want to save memory

**Example:**

```dart
class User {
  final String name;           // Different for each user
  final DateTime createdAt;    // When user registered
  static const int maxAge = 120;  // Same for all users
  
  User(this.name) : createdAt = DateTime.now();
}

void main() {
  const appName = "MyApp";        // Never changes
  const version = "1.0.0";        // Known in code
  
  final user = User("Ali");       // Created at runtime
  final today = DateTime.now();   // Runtime value
  
  print("$appName v$version");
  print("User: ${user.name}");
}
```

---

## All Dart Data Types

### 1. Numbers

```dart
void main() {
  // int - whole numbers
  int age = 25;
  int negative = -10;
  int large = 1000000;
  
  // double - decimal numbers
  double height = 5.9;
  double pi = 3.14159;
  double negative2 = -2.5;
  
  // num - can be int OR double
  num value1 = 10;      // int
  num value2 = 10.5;    // double
  
  // Calculations
  int sum = 10 + 5;           // 15
  int difference = 10 - 5;    // 5
  int product = 10 * 5;       // 50
  double division = 10 / 3;   // 3.3333...
  int intDivision = 10 ~/ 3;  // 3 (removes decimal)
  int remainder = 10 % 3;     // 1 (modulo)
  
  print("Sum: $sum");
  print("Division: $division");
  print("Integer Division: $intDivision");
}
```

**When to use which?**
- `int` - counting, whole numbers (age, quantity)
- `double` - measurements, money, precise calculations
- `num` - when it could be either (rare)

### 2. Strings

```dart
void main() {
  // Single quotes or double quotes - same thing
  String name1 = 'Moussaab';
  String name2 = "Moussaab";
  
  // String concatenation
  String firstName = "Moussaab";
  String lastName = "Badla";
  String fullName = firstName + " " + lastName;
  
  // String interpolation (better way)
  String greeting = "Hello, my name is $firstName $lastName";
  String info = "I am ${age + 5} years old";  // Can do calculations
  
  // Multi-line strings
  String multiLine1 = '''
This is a
multi-line
string with single quotes
''';
  
  String multiLine2 = """
This is a
multi-line
string with double quotes
""";
  
  // Escape characters
  String newLine = "Line 1\nLine 2";      // \n = new line
  String tab = "Name:\tMoussaab";         // \t = tab
  String quote = "He said \"Hello\"";     // \" = quote in string
  String backslash = "Path: C:\\Users";   // \\ = backslash
  
  print(greeting);
  print(newLine);
}
```

### 3. Boolean

```dart
void main() {
  bool isStudent = true;
  bool isMarried = false;
  bool hasLicense = true;
  
  // Boolean operations
  bool result1 = true && false;   // AND - false
  bool result2 = true || false;   // OR - true
  bool result3 = !true;           // NOT - false
  
  // Comparisons return bool
  bool isAdult = age >= 18;       // true or false
  bool isEqual = (5 == 5);        // true
  bool notEqual = (5 != 3);       // true
  
  print("Is student? $isStudent");
  print("Is adult? $isAdult");
}
```

### 4. Lists (Arrays)

```dart
void main() {
  // List of integers
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // List of strings
  List<String> names = ["Ali", "Ahmed", "Sara"];
  
  // List with var
  var cities = ["Algiers", "Oran", "Constantine"];
  
  // Access elements (starts at 0)
  print(numbers[0]);        // 1
  print(names[2]);          // Sara
  
  // List operations
  numbers.add(6);           // Add item
  numbers.remove(3);        // Remove item
  print(numbers.length);    // Number of items
  
  // Empty list
  List<String> emptyList = [];
}
```

### 5. Maps (Key-Value Pairs)

```dart
void main() {
  // Map with String keys and dynamic values
  Map<String, dynamic> person = {
    "name": "Moussaab",
    "age": 25,
    "city": "Algiers",
    "isStudent": true
  };
  
  // Access values
  print(person["name"]);    // Moussaab
  print(person["age"]);     // 25
  
  // Add new key-value
  person["phone"] = "0555123456";
  
  // Map with var
  var user = {
    "id": 1,
    "email": "user@example.com"
  };
}
```

### 6. Sets (Unique Items)

```dart
void main() {
  // Set - no duplicates allowed
  Set<int> uniqueNumbers = {1, 2, 3, 4, 5};
  
  // Trying to add duplicate does nothing
  uniqueNumbers.add(3);
  print(uniqueNumbers);  // Still {1, 2, 3, 4, 5}
  
  // Set with var
  var cities = {"Algiers", "Oran", "Algiers"};  // Duplicate removed
  print(cities);  // {Algiers, Oran}
}
```

### 7. Runes (Unicode Characters)

```dart
void main() {
  // For emojis and special characters
  Runes heart = Runes('\u2665');
  String emoji = String.fromCharCodes(heart);
  print(emoji);  // ♥
  
  // Easier way
  String smile = '\u{1F600}';
  print(smile);  // 😀
}
```

---

## Records (Tuples)

Records are Dart's version of tuples - they let you group multiple values together without creating a class. Introduced in Dart 3.0, records are immutable and can hold different types of data.

### What Are Records?

**Simple explanation:** Records let you put multiple values in parentheses `()` and return them together.

**Before Dart 3.0:** You needed a class or a package to return multiple values.

**After Dart 3.0:** Just use records!

### Basic Record Syntax

```dart
void main() {
  // Simple record with 2 values
  var person = ("Moussaab", 25);
  print(person);  // (Moussaab, 25)
  
  // Access values with $1, $2, $3...
  print(person.$1);  // Moussaab
  print(person.$2);  // 25
  
  // Record with different types
  var mixed = ("Algeria", 44000000, true, 2.38);
  print(mixed.$1);  // Algeria (String)
  print(mixed.$2);  // 44000000 (int)
  print(mixed.$3);  // true (bool)
  print(mixed.$4);  // 2.38 (double)
}
```

### Named Records (Better Readability)

Instead of using $1, $2, you can give names to record fields using colons.

```dart
void main() {
  // Named record
  var person = (name: "Moussaab", age: 25, city: "Algiers");
  
  // Access by name
  print(person.name);  // Moussaab
  print(person.age);   // 25
  print(person.city);  // Algiers
  
  // Mixed: positional and named
  var user = ("Moussaab", age: 25, isActive: true);
  print(user.$1);        // Moussaab (positional)
  print(user.age);       // 25 (named)
  print(user.isActive);  // true (named)
}
```

### Type Annotations for Records

```dart
void main() {
  // Specify the type
  (String, int) person = ("Moussaab", 25);
  
  // Named fields with types
  ({String name, int age}) user = (name: "Ali", age: 30);
  
  // Mixed
  (String, {int age, bool isStudent}) data = (
    "Ahmed",
    age: 20,
    isStudent: true
  );
}
```

### Returning Multiple Values from Functions

**This is where records shine!**

```dart
// Return multiple values
(String, int, String) getUserInfo() {
  return ("Moussaab", 25, "Algiers");
}

void main() {
  // Get all values
  var userInfo = getUserInfo();
  print(userInfo.$1);  // Moussaab
  print(userInfo.$2);  // 25
  print(userInfo.$3);  // Algiers
  
  // Destructure into variables (pattern matching)
  var (name, age, city) = getUserInfo();
  print("Name: $name");
  print("Age: $age");
  print("City: $city");
}
```

### Named Returns (More Readable)

```dart
// Return with named fields
({String name, int age, String city}) getUserInfo() {
  return (name: "Moussaab", age: 25, city: "Algiers");
}

void main() {
  var user = getUserInfo();
  print(user.name);  // More readable than user.$1
  print(user.age);
  print(user.city);
  
  // Destructure named fields
  var (:name, :age, :city) = getUserInfo();
  print("$name is $age years old from $city");
}
```

### Real-World Example: Form Validation

```dart
// Validate email and return result + error message
(bool, String) validateEmail(String email) {
  if (email.isEmpty) {
    return (false, "Email cannot be empty");
  }
  if (!email.contains("@")) {
    return (false, "Email must contain @");
  }
  return (true, "Valid email");
}

void main() {
  // Check validation
  var (isValid, message) = validateEmail("test@email.com");
  
  if (isValid) {
    print("✅ $message");
  } else {
    print("❌ $message");
  }
}
```

### Real-World Example: API Response

```dart
// Simulate API call that returns data and status
(int statusCode, Map<String, dynamic> data) fetchUser(int id) {
  if (id <= 0) {
    return (400, {"error": "Invalid ID"});
  }
  
  return (200, {
    "id": id,
    "name": "Moussaab",
    "email": "moussaab@example.com"
  });
}

void main() {
  var (status, data) = fetchUser(1);
  
  if (status == 200) {
    print("Success: ${data['name']}");
  } else {
    print("Error: ${data['error']}");
  }
}
```

### Record Equality

Two records are equal if they have the same structure and values.

```dart
void main() {
  var point1 = (x: 10, y: 20);
  var point2 = (x: 10, y: 20);
  var point3 = (x: 10, y: 30);
  
  print(point1 == point2);  // true - same structure and values
  print(point1 == point3);  // false - different values
  
  // Positional records
  var color1 = (255, 128, 0);
  var color2 = (255, 128, 0);
  print(color1 == color2);  // true
}
```

### Records vs Classes

**When to use records:**
- Quick data grouping
- Returning multiple values from functions
- Temporary data structures
- Simple data without behavior

**When to use classes:**
- Need methods/functions
- Complex data structures
- Need inheritance
- Object-oriented design

```dart
// Record - simple data
var point = (x: 10, y: 20);

// Class - data + behavior
class Point {
  final int x;
  final int y;
  
  Point(this.x, this.y);
  
  double distanceFromOrigin() {
    return sqrt(x * x + y * y);
  }
}
```

### Record Tips

**✅ Do:**
- Use records for functions returning multiple values
- Use named fields for clarity
- Use records for simple data grouping

**❌ Don't:**
- Use records for complex data structures
- Use too many fields (use a class instead)
- Use records when you need methods

---

## String Special Features

### 1. Multi-line Strings

```dart
void main() {
  // Triple quotes for multi-line
  String address = '''
123 Main Street
Building 5, Apartment 12
Algiers, Algeria
''';
  
  String code = """
void main() {
  print('Hello');
}
""";
  
  print(address);
  print(code);
}
```

### 2. Raw Strings

```dart
void main() {
  // r prefix - ignores escape characters
  String path = r'C:\Users\Moussaab\Documents';
  print(path);  // C:\Users\Moussaab\Documents
  
  // Without r, you'd need \\
  String path2 = 'C:\\Users\\Moussaab\\Documents';
  print(path2);  // Same output
}
```

### 3. String Interpolation

```dart
void main() {
  String name = "Moussaab";
  int age = 25;
  
  // $ for variables
  print("Name: $name");
  
  // ${} for expressions
  print("Next year I'll be ${age + 1}");
  print("My name is ${name.toUpperCase()}");
  print("Name length: ${name.length}");
}
```

### 4. Escape Characters

```dart
void main() {
  print("Line 1\nLine 2");           // New line
  print("Column1\tColumn2");         // Tab
  print("He said \"Hello\"");        // Quote inside string
  print("Path: C:\\folder");         // Backslash
  print("Unicode: \u{1F600}");       // Emoji
}
```

Output:
```
Line 1
Line 2
Column1    Column2
He said "Hello"
Path: C:\folder
Unicode: 😀
```

---

## Practice Code Examples

### Example 1: Enhanced Variable Demonstration

```dart
void main() {
  // === var vs Type Declaration ===
  var inferredName = "Moussaab";  // Type inferred as String
  String explicitName = "Badla";   // Type explicitly declared
  
  print("Full name: $inferredName $explicitName");
  
  // === Numbers with operations ===
  int num1 = 10;
  int num2 = 3;
  
  int sum = num1 + num2;          // 13
  int difference = num1 - num2;   // 7
  int product = num1 * num2;      // 30
  double division = num1 / num2;  // 3.3333...
  int intDivision = num1 ~/ num2; // 3
  int modulo = num1 % num2;       // 1
  
  print("=== Math Operations ===");
  print("Sum: $sum");
  print("Difference: $difference");
  print("Product: $product");
  print("Division: $division");
  print("Integer Division: $intDivision");
  print("Remainder: $modulo");
  
  // === Using num (flexible number type) ===
  num flexibleNumber = 10;    // Can be int
  flexibleNumber = 10.5;      // Can change to double
  print("Flexible number: $flexibleNumber");
  
  // === Person information ===
  String name = "Moussaab";
  String address = "Algiers, Algeria";
  int age = 25;
  double height = 5.9;
  bool isMarried = false;
  bool isStudent = true;
  
  print("\n=== Person Info ===");
  print("Name: $name");
  print("Address: $address");
  print("Age: $age years old");
  print("Height: $height feet");
  print("Married: ${isMarried ? 'Yes' : 'No'}");
  print("Student: ${isStudent ? 'Yes' : 'No'}");
  
  // === Multi-line strings ===
  String bio = '''
Name: $name
Location: $address
Status: ${isStudent ? 'Student' : 'Professional'}
''';
  
  String codeExample = """
This is a code example:
void main() {
  print('Hello Dart!');
}
""";
  
  print("\n=== Multi-line Text ===");
  print(bio);
  print(codeExample);
  
  // === Escape characters ===
  print("\n=== Escape Characters ===");
  print("I am from \nAlgeria.");        // New line
  print("Name:\tMoussaab");             // Tab
  print("He said: \"Hello World\"");    // Quotes
  
  // === Lists ===
  List<String> cities = ["Algiers", "Oran", "Constantine"];
  print("\n=== List Example ===");
  print("Cities: $cities");
  print("First city: ${cities[0]}");
  print("Number of cities: ${cities.length}");
  
  // === Maps ===
  Map<String, dynamic> userData = {
    "name": name,
    "age": age,
    "city": address,
    "skills": ["Dart", "Flutter", "Python"]
  };
  
  print("\n=== Map Example ===");
  print("User data: $userData");
  print("Skills: ${userData['skills']}");
}
```

### Example 2: Records in Action

```dart
void main() {
  print("=== Records Examples ===\n");
  
  // Simple record
  var coordinates = (10, 20);
  print("Point: (${coordinates.$1}, ${coordinates.$2})");
  
  // Named record
  var person = (name: "Moussaab", age: 25, city: "Algiers");
  print("Person: ${person.name}, ${person.age}, ${person.city}");
  
  // Function returning multiple values
  var (width, height) = getScreenSize();
  print("Screen: ${width}x$height");
  
  // Validation example
  var (isValid, error) = validateAge(15);
  if (isValid) {
    print("✅ Age is valid");
  } else {
    print("❌ Error: $error");
  }
  
  // API response example
  var (status, user) = fetchUserData(1);
  print("\nAPI Response:");
  print("Status: $status");
  print("User: $user");
}

// Function returning record
(int, int) getScreenSize() {
  return (1920, 1080);
}

// Validation function
(bool, String) validateAge(int age) {
  if (age < 0) {
    return (false, "Age cannot be negative");
  }
  if (age < 18) {
    return (false, "Must be 18 or older");
  }
  return (true, "Valid age");
}

// API simulation
(int, Map<String, dynamic>) fetchUserData(int id) {
  return (200, {
    "id": id,
    "name": "Moussaab",
    "email": "moussaab@example.com"
  });
}
```

### Example 3: final vs const

```dart
void main() {
  print("=== final vs const ===\n");
  
  // const - compile-time constant
  const String appName = "My Dart App";
  const double pi = 3.14159;
  const int maxUsers = 1000;
  
  print("App: $appName");
  print("Pi: $pi");
  print("Max users: $maxUsers");
  
  // final - runtime constant
  final String currentDate = DateTime.now().toString();
  final int randomNumber = DateTime.now().millisecond;
  
  print("\nCurrent date: $currentDate");
  print("Random: $randomNumber");
  
  // const in collections
  const List<String> daysOfWeek = [
    "Monday", "Tuesday", "Wednesday", 
    "Thursday", "Friday", "Saturday", "Sunday"
  ];
  
  print("\nDays: $daysOfWeek");
  
  // final in collections
  final List<int> scores = [85, 92, 78, 95];
  scores.add(88);  // ✅ Can modify list contents
  // scores = [1, 2, 3];  // ❌ Cannot reassign
  
  print("Scores: $scores");
}
```

### Example 4: dynamic in Action

```dart
void main() {
  print("=== dynamic Type ===\n");
  
  dynamic value = "Hello";
  print("Value: $value (${value.runtimeType})");
  
  value = 123;
  print("Value: $value (${value.runtimeType})");
  
  value = 45.67;
  print("Value: $value (${value.runtimeType})");
  
  value = true;
  print("Value: $value (${value.runtimeType})");
  
  value = ["Dart", "Flutter", "Firebase"];
  print("Value: $value (${value.runtimeType})");
  
  // Working with JSON (common use of dynamic)
  Map<String, dynamic> jsonData = {
    "name": "Moussaab",
    "age": 25,
    "skills": ["Dart", "Flutter"],
    "address": {
      "city": "Algiers",
      "country": "Algeria"
    }
  };
  
  print("\nJSON Data:");
  print("Name: ${jsonData['name']}");
  print("Age: ${jsonData['age']}");
  print("First skill: ${jsonData['skills'][0]}");
  print("City: ${jsonData['address']['city']}");
}
```

---

## Summary Table

### Declaration Types

| Type | Can change value? | Can change type? | When to use |
|------|------------------|------------------|-------------|
| `var name = "Ali"` | ✅ Yes | ❌ No | Quick coding, type is obvious |
| `String name = "Ali"` | ✅ Yes | ❌ No | When type matters |
| `dynamic value` | ✅ Yes | ✅ Yes | JSON, unknown types |
| `final name = "Ali"` | ❌ No | ❌ No | Runtime constants |
| `const name = "Ali"` | ❌ No | ❌ No | Compile-time constants |

### Data Types

| Type | Example | Use |
|------|---------|-----|
| `int` | `42` | Whole numbers |
| `double` | `3.14` | Decimal numbers |
| `num` | `10` or `10.5` | Flexible number |
| `String` | `"Hello"` | Text |
| `bool` | `true` or `false` | True/False |
| `List` | `[1, 2, 3]` | Ordered collection |
| `Map` | `{"key": "value"}` | Key-value pairs |
| `Set` | `{1, 2, 3}` | Unique items |
| `Record` | `(name: "Ali", age: 25)` | Multiple values grouped |

---

## Quick Reference Guide

### When to Use What?

**Quick decision tree:**

```
Need to store data?
│
├─ Value never changes after first set?
│  ├─ Value known when writing code? → use const
│  └─ Value calculated at runtime? → use final
│
├─ Type might change later?
│  └─ use dynamic (careful!)
│
├─ Type is obvious from value?
│  └─ use var
│
└─ Want to be explicit about type?
   └─ use Type declaration (String, int, etc.)
```

### Common Patterns

```dart
// Configuration (use const)
const String apiUrl = "https://api.example.com";
const int timeout = 30;

// User input (use final)
final String userName = getUserInput();
final DateTime loginTime = DateTime.now();

// Calculations (use var or type)
var result = calculateTotal();
int score = getScore();

// JSON data (use dynamic or Map<String, dynamic>)
dynamic jsonResponse = await fetchData();
Map<String, dynamic> userData = parseJson();

// Return multiple values (use records)
(bool, String) validateForm() {
  return (true, "Valid");
}
```

---

## Best Practices

### ✅ Good Practices

```dart
// 1. Use const for compile-time constants
const double pi = 3.14159;
const String appVersion = "1.0.0";

// 2. Use final for runtime constants
final DateTime now = DateTime.now();
final String userId = generateId();

// 3. Use specific types in function parameters
String greet(String name) {  // Clear what type is expected
  return "Hello, $name";
}

// 4. Use var when type is obvious
var name = "Moussaab";  // Obviously String
var age = 25;           // Obviously int

// 5. Use records for multiple return values
(int, String) getStatus() {
  return (200, "OK");
}

// 6. Use named records for clarity
({String name, int age}) getPerson() {
  return (name: "Ali", age: 30);
}
```

### ❌ Bad Practices

```dart
// 1. Avoid dynamic unless necessary
dynamic data = "Hello";  // Use String instead

// 2. Don't use var when type isn't obvious
var data = fetchFromDatabase();  // What type is this?
// Better: use the actual type

// 3. Don't use const when value is runtime
// const time = DateTime.now();  // ERROR
final time = DateTime.now();     // Correct

// 4. Avoid too many positional record fields
var data = (1, "text", true, 3.14, "more", false);  // Hard to read
// Better: use named fields or a class

// 5. Don't change final references
final list = [1, 2, 3];
// list = [4, 5, 6];  // ERROR - cannot reassign
list.add(4);          // OK - can modify contents
```

---

## Common Mistakes and Solutions

### Mistake 1: Trying to change final/const

```dart
// ❌ Wrong
final name = "Ali";
name = "Ahmed";  // ERROR

// ✅ Correct
var name = "Ali";
name = "Ahmed";  // OK
```

### Mistake 2: Using const with runtime values

```dart
// ❌ Wrong
const currentTime = DateTime.now();  // ERROR

// ✅ Correct
final currentTime = DateTime.now();  // OK
```

### Mistake 3: Confusing var and dynamic

```dart
// var - type is locked
var name = "Ali";
// name = 123;  // ERROR - type is locked to String

// dynamic - type can change
dynamic value = "Ali";
value = 123;  // OK - type can change
```

### Mistake 4: Not using null safety

```dart
// ❌ Old way (Dart 2.0)
String name;
print(name.length);  // Might crash if null

// ✅ New way (Dart 3.0+)
String? name;  // Nullable
if (name != null) {
  print(name.length);  // Safe
}

String name2 = "Ali";  // Non-nullable
print(name2.length);   // Always safe
```

### Mistake 5: Wrong record field access

```dart
// ❌ Wrong
var person = (name: "Ali", age: 25);
print(person.$1);  // Wrong - use person.name

// ✅ Correct
print(person.name);  // Correct for named fields

// For positional records:
var point = (10, 20);
print(point.$1);  // Correct - 10
print(point.$2);  // Correct - 20
```

---

## Real-World Examples

### Example 5: Complete User Management

```dart
void main() {
  print("=== User Management System ===\n");
  
  // Constants for configuration
  const String appName = "UserApp";
  const String version = "1.0.0";
  const int maxLoginAttempts = 3;
  
  print("$appName v$version");
  print("Max login attempts: $maxLoginAttempts\n");
  
  // Create user with record
  var user = createUser("moussaab@example.com", "password123");
  var (success, message, userData) = user;
  
  if (success) {
    print("✅ $message");
    print("User ID: ${userData?['id']}");
    print("Email: ${userData?['email']}");
    print("Created: ${userData?['createdAt']}\n");
  } else {
    print("❌ $message\n");
  }
  
  // Login attempt
  var loginResult = attemptLogin("moussaab@example.com", "password123");
  var (loginSuccess, loginMessage, token) = loginResult;
  
  if (loginSuccess) {
    print("✅ Login successful");
    print("Token: $token");
  } else {
    print("❌ Login failed: $loginMessage");
  }
}

// Function returning record with multiple values
(bool, String, Map<String, dynamic>?) createUser(
  String email, 
  String password
) {
  // Validation
  if (email.isEmpty || !email.contains("@")) {
    return (false, "Invalid email", null);
  }
  
  if (password.length < 8) {
    return (false, "Password too short", null);
  }
  
  // Create user data
  final userData = {
    "id": DateTime.now().millisecondsSinceEpoch,
    "email": email,
    "createdAt": DateTime.now().toString(),
  };
  
  return (true, "User created successfully", userData);
}

// Login function with record return
(bool, String, String?) attemptLogin(String email, String password) {
  // Simulate authentication
  if (email == "moussaab@example.com" && password == "password123") {
    final token = "token_${DateTime.now().millisecondsSinceEpoch}";
    return (true, "Login successful", token);
  }
  
  return (false, "Invalid credentials", null);
}
```

### Example 6: Shopping Cart

```dart
void main() {
  print("=== Shopping Cart ===\n");
  
  // Product catalog (const - never changes)
  const Map<String, double> productPrices = {
    "Laptop": 999.99,
    "Mouse": 29.99,
    "Keyboard": 79.99,
    "Monitor": 299.99,
  };
  
  // Shopping cart (final - set once but contents can change)
  final Map<String, int> cart = {};
  
  // Add items to cart
  addToCart(cart, "Laptop", 1);
  addToCart(cart, "Mouse", 2);
  addToCart(cart, "Keyboard", 1);
  
  print("Cart contents:");
  cart.forEach((product, quantity) {
    print("  $product x$quantity");
  });
  
  // Calculate total using record return
  var (subtotal, tax, total) = calculateTotal(cart, productPrices);
  
  print("\n--- Order Summary ---");
  print("Subtotal: \${subtotal.toStringAsFixed(2)}");
  print("Tax (10%): \${tax.toStringAsFixed(2)}");
  print("Total: \${total.toStringAsFixed(2)}");
}

void addToCart(Map<String, int> cart, String product, int quantity) {
  if (cart.containsKey(product)) {
    cart[product] = cart[product]! + quantity;
  } else {
    cart[product] = quantity;
  }
  print("✅ Added $quantity x $product to cart");
}

// Calculate totals and return multiple values with record
(double, double, double) calculateTotal(
  Map<String, int> cart,
  Map<String, double> prices,
) {
  double subtotal = 0;
  
  cart.forEach((product, quantity) {
    if (prices.containsKey(product)) {
      subtotal += prices[product]! * quantity;
    }
  });
  
  double tax = subtotal * 0.10;  // 10% tax
  double total = subtotal + tax;
  
  return (subtotal, tax, total);
}
```

### Example 7: Temperature Converter

```dart
void main() {
  print("=== Temperature Converter ===\n");
  
  // Input temperature
  final double celsius = 25.0;
  
  // Convert using function that returns record
  var (fahrenheit, kelvin, description) = convertTemperature(celsius);
  
  print("Temperature: ${celsius}°C");
  print("Fahrenheit: ${fahrenheit.toStringAsFixed(1)}°F");
  print("Kelvin: ${kelvin.toStringAsFixed(1)}K");
  print("Description: $description");
  
  print("\n--- Temperature Table ---");
  
  // Create a temperature table
  const List<int> temperatures = [0, 10, 20, 30, 40];
  
  for (var temp in temperatures) {
    var (f, k, desc) = convertTemperature(temp.toDouble());
    print("${temp}°C = ${f.toStringAsFixed(0)}°F = ${k.toStringAsFixed(0)}K - $desc");
  }
}

// Function returning named record
({double fahrenheit, double kelvin, String description}) convertTemperature(
  double celsius
) {
  double fahrenheit = (celsius * 9 / 5) + 32;
  double kelvin = celsius + 273.15;
  
  String description;
  if (celsius < 0) {
    description = "Freezing";
  } else if (celsius < 15) {
    description = "Cold";
  } else if (celsius < 25) {
    description = "Mild";
  } else if (celsius < 35) {
    description = "Warm";
  } else {
    description = "Hot";
  }
  
  return (
    fahrenheit: fahrenheit,
    kelvin: kelvin,
    description: description
  );
}
```

---

## Interview Questions & Answers

### Q1: What's the difference between var and dynamic?

**Answer:**
- `var`: Type is decided once based on first value, then locked
- `dynamic`: Type can change any time during program execution

```dart
var name = "Ali";
// name = 123;  // ERROR

dynamic value = "Ali";
value = 123;  // OK
```

### Q2: When should I use final vs const?

**Answer:**
- `final`: For runtime constants (value calculated when program runs)
- `const`: For compile-time constants (value known when writing code)

```dart
final time = DateTime.now();  // Runtime
const pi = 3.14159;           // Compile-time
```

### Q3: What are records and why use them?

**Answer:**
Records (tuples) let you return multiple values from a function without creating a class. Introduced in Dart 3.0.

```dart
(int, String) getStatus() {
  return (200, "Success");
}

var (code, message) = getStatus();
```

### Q4: Can I modify a final variable?

**Answer:**
You cannot reassign a `final` variable, but you can modify its contents if it's a collection.

```dart
final list = [1, 2, 3];
// list = [4, 5, 6];  // ERROR - cannot reassign
list.add(4);          // OK - can modify contents
```

### Q5: What's the difference between num, int, and double?

**Answer:**
- `int`: Whole numbers only (1, 2, 100)
- `double`: Decimal numbers only (1.5, 3.14)
- `num`: Can be either int or double

```dart
num value = 10;     // int
value = 10.5;       // now double - allowed with num
```

---

## Exercises

### Exercise 1: Fix the Code

Find and fix the errors:

```dart
// Fix these errors
const currentTime = DateTime.now();
var name = "Ali";
name = 123;
final age = 25;
age = 26;
```

**Solution:**
```dart
final currentTime = DateTime.now();  // Use final, not const
var name = "Ali";
name = "Ahmed";  // Keep same type
final age = 25;
// age = 26;  // Remove this - final cannot be changed
```

### Exercise 2: Complete the Function

Write a function that validates a password and returns:
- Is it valid? (bool)
- Error message (String)
- Password strength (String: "Weak", "Medium", "Strong")

```dart
// Your code here
(bool, String, String) validatePassword(String password) {
  // Complete this function
}
```

**Solution:**
```dart
(bool, String, String) validatePassword(String password) {
  if (password.length < 6) {
    return (false, "Password too short", "Weak");
  }
  
  bool hasNumber = password.contains(RegExp(r'[0-9]'));
  bool hasUpper = password.contains(RegExp(r'[A-Z]'));
  bool hasLower = password.contains(RegExp(r'[a-z]'));
  
  if (password.length >= 12 && hasNumber && hasUpper && hasLower) {
    return (true, "Strong password", "Strong");
  } else if (password.length >= 8 && (hasNumber || hasUpper)) {
    return (true, "Good password", "Medium");
  } else {
    return (false, "Password too weak", "Weak");
  }
}
```

### Exercise 3: Create a Record-Based Calculator

Create a calculator that returns:
- Result of operation
- Success status
- Message

```dart
// Your code here
```

**Solution:**
```dart
({bool success, double result, String message}) calculate(
  double num1,
  double num2,
  String operation,
) {
  switch (operation) {
    case '+':
      return (
        success: true,
        result: num1 + num2,
        message: "Addition successful"
      );
    case '-':
      return (
        success: true,
        result: num1 - num2,
        message: "Subtraction successful"
      );
    case '*':
      return (
        success: true,
        result: num1 * num2,
        message: "Multiplication successful"
      );
    case '/':
      if (num2 == 0) {
        return (
          success: false,
          result: 0,
          message: "Cannot divide by zero"
        );
      }
      return (
        success: true,
        result: num1 / num2,
        message: "Division successful"
      );
    default:
      return (
        success: false,
        result: 0,
        message: "Invalid operation"
      );
  }
}

void main() {
  var result = calculate(10, 5, '+');
  if (result.success) {
    print("Result: ${result.result} - ${result.message}");
  } else {
    print("Error: ${result.message}");
  }
}
```

---

## Cheat Sheet

### Variable Declaration Quick Reference

```dart
// Regular variables
var name = "Ali";           // Type inferred
String name = "Ali";        // Type explicit
dynamic value = "Ali";      // Can change type

// Constants
final now = DateTime.now(); // Runtime constant
const pi = 3.14159;        // Compile-time constant

// Numbers
int age = 25;              // Whole number
double height = 5.9;       // Decimal
num value = 10;            // Either int or double

// Strings
String text = "Hello";     // Text
String multi = '''
  Multiple
  lines
''';

// Collections
List<int> nums = [1, 2, 3];           // Array
Map<String, int> ages = {"Ali": 25};  // Dictionary
Set<int> unique = {1, 2, 3};          // Unique items

// Records (Dart 3.0+)
var point = (x: 10, y: 20);           // Named record
var data = (1, "text", true);         // Positional record
```

---


### Testing Types

```dart
void main() {
  var value = "Hello";
  print(value.runtimeType);  // String
  print(value is String);    // true
  print(value is int);       // false
}
```

---


