# Dart Operations, Conditions, Loops & Functions

**Master the fundamentals of Dart programming**

---

## Table of Contents

1. [Operators](#operators)
2. [Conditional Statements](#conditional-statements)
3. [Loops](#loops)
4. [Functions](#functions)
5. [Practice Examples](#practice-examples)

---

## Operators

Operators are symbols that perform operations on variables and values.

### 1. Arithmetic Operators

Do math calculations.

```dart
void main() {
  int a = 10;
  int b = 3;
  
  print("Addition: ${a + b}");        // 13
  print("Subtraction: ${a - b}");     // 7
  print("Multiplication: ${a * b}");  // 30
  print("Division: ${a / b}");        // 3.3333 (double)
  print("Integer Division: ${a ~/ b}"); // 3 (removes decimal)
  print("Modulo (remainder): ${a % b}"); // 1
  
  // Unary operators
  print("Negative: ${-a}");           // -10
}
```

**Quick reference:**

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | Division | `5 / 2` | `2.5` |
| `~/` | Integer Division | `5 ~/ 2` | `2` |
| `%` | Modulo | `5 % 2` | `1` |

---

### 2. Increment/Decrement Operators

```dart
void main() {
  int count = 5;
  
  // Post-increment (use then add)
  print(count++);  // Prints 5, then becomes 6
  print(count);    // 6
  
  // Pre-increment (add then use)
  print(++count);  // Becomes 7, then prints 7
  print(count);    // 7
  
  // Post-decrement (use then subtract)
  print(count--);  // Prints 7, then becomes 6
  print(count);    // 6
  
  // Pre-decrement (subtract then use)
  print(--count);  // Becomes 5, then prints 5
  print(count);    // 5
}
```

**Simple explanation:**
- `count++` → Use the value, **then** add 1
- `++count` → Add 1, **then** use the value
- `count--` → Use the value, **then** subtract 1
- `--count` → Subtract 1, **then** use the value

---

### 3. Comparison Operators

Compare two values and return true or false.

```dart
void main() {
  int a = 10;
  int b = 5;
  
  print("Equal: ${a == b}");              // false
  print("Not equal: ${a != b}");          // true
  print("Greater than: ${a > b}");        // true
  print("Less than: ${a < b}");           // false
  print("Greater or equal: ${a >= b}");   // true
  print("Less or equal: ${a <= b}");      // false
}
```

**Quick reference:**

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `==` | Equal to | `5 == 5` | `true` |
| `!=` | Not equal | `5 != 3` | `true` |
| `>` | Greater than | `5 > 3` | `true` |
| `<` | Less than | `5 < 3` | `false` |
| `>=` | Greater or equal | `5 >= 5` | `true` |
| `<=` | Less or equal | `5 <= 3` | `false` |

---

### 4. Logical Operators

Combine multiple conditions.

```dart
void main() {
  int age = 25;
  bool hasLicense = true;
  bool hasInsurance = false;
  
  // AND - both must be true
  print("Can drive: ${age >= 18 && hasLicense}");  // true
  print("Legal driver: ${hasLicense && hasInsurance}");  // false
  
  // OR - at least one must be true
  print("Adult or licensed: ${age >= 18 || hasLicense}");  // true
  print("Has docs: ${hasLicense || hasInsurance}");  // true
  
  // NOT - reverses the value
  print("Not licensed: ${!hasLicense}");  // false
  print("No insurance: ${!hasInsurance}");  // true
}
```

**Truth tables:**

**AND (`&&`)** - Both must be true:
```
true  && true  = true
true  && false = false
false && true  = false
false && false = false
```

**OR (`||`)** - At least one must be true:
```
true  || true  = true
true  || false = true
false || true  = true
false || false = false
```

**NOT (`!`)** - Reverses:
```
!true  = false
!false = true
```

---

### 5. Assignment Operators

Assign values to variables.

```dart
void main() {
  int num = 10;
  
  // Basic assignment
  num = 5;
  print(num);  // 5
  
  // Compound assignments
  num += 3;  // Same as: num = num + 3
  print(num);  // 8
  
  num -= 2;  // Same as: num = num - 2
  print(num);  // 6
  
  num *= 2;  // Same as: num = num * 2
  print(num);  // 12
  
  num ~/= 5;  // Same as: num = num ~/ 5
  print(num);  // 2
  
  num %= 2;  // Same as: num = num % 2
  print(num);  // 0
}
```

**Quick reference:**

| Operator | Meaning | Example | Same as |
|----------|---------|---------|---------|
| `=` | Assign | `a = 5` | - |
| `+=` | Add and assign | `a += 3` | `a = a + 3` |
| `-=` | Subtract and assign | `a -= 3` | `a = a - 3` |
| `*=` | Multiply and assign | `a *= 3` | `a = a * 3` |
| `/=` | Divide and assign | `a /= 3` | `a = a / 3` |
| `~/=` | Int divide and assign | `a ~/= 3` | `a = a ~/ 3` |
| `%=` | Modulo and assign | `a %= 3` | `a = a % 3` |

---

### 6. Type Test Operators

Check the type of a variable.

```dart
void main() {
  var value = "Hello";
  
  // is - checks if variable is a type
  print(value is String);   // true
  print(value is int);      // false
  
  // is! - checks if variable is NOT a type
  print(value is! String);  // false
  print(value is! int);     // true
  
  // Practical use
  dynamic data = 123;
  
  if (data is int) {
    print("It's a number: ${data * 2}");
  } else if (data is String) {
    print("It's text: ${data.toUpperCase()}");
  }
}
```

---

### 7. Null-aware Operators

Work safely with null values.

```dart
void main() {
  String? name;  // Can be null
  String? city = "Algiers";
  
  // ?? - use default if null
  print(name ?? "Unknown");  // Unknown (name is null)
  print(city ?? "Unknown");  // Algiers (city is not null)
  
  // ??= - assign if null
  name ??= "Ali";  // Sets name to "Ali" because it's null
  print(name);     // Ali
  
  name ??= "Ahmed";  // Does nothing (name already has value)
  print(name);       // Still Ali
  
  // ?. - safe call (only if not null)
  String? text;
  print(text?.length);  // null (doesn't crash)
  
  text = "Hello";
  print(text?.length);  // 5
  
  // ! - force unwrap (dangerous!)
  String? message = "Hi";
  print(message!.length);  // 2 (works, but risky)
  
  // String? empty;
  // print(empty!.length);  // CRASH at runtime!
}
```

**Null-aware operators summary:**

| Operator | Name | Use |
|----------|------|-----|
| `??` | If null | `value ?? default` |
| `??=` | Assign if null | `value ??= default` |
| `?.` | Safe access | `object?.property` |
| `!` | Force unwrap | `nullableValue!` |

---

### 8. Ternary Operator

Short if-else statement.

```dart
void main() {
  int age = 20;
  
  // Ternary: condition ? valueIfTrue : valueIfFalse
  String status = age >= 18 ? "Adult" : "Minor";
  print(status);  // Adult
  
  // Instead of:
  String status2;
  if (age >= 18) {
    status2 = "Adult";
  } else {
    status2 = "Minor";
  }
  print(status2);  // Adult
  
  // More examples
  int score = 85;
  String grade = score >= 90 ? "A" :
                 score >= 80 ? "B" :
                 score >= 70 ? "C" : "F";
  print("Grade: $grade");  // B
}
```

---

### 9. Cascade Operator

Perform multiple operations on the same object.

```dart
void main() {
  // Without cascade
  List<int> numbers1 = [1, 2, 3];
  numbers1.add(4);
  numbers1.add(5);
  numbers1.remove(1);
  print(numbers1);  // [2, 3, 4, 5]
  
  // With cascade (..)
  List<int> numbers2 = [1, 2, 3]
    ..add(4)
    ..add(5)
    ..remove(1);
  print(numbers2);  // [2, 3, 4, 5]
  
  // More complex example
  StringBuffer buffer = StringBuffer()
    ..write("Hello")
    ..write(" ")
    ..write("World")
    ..write("!");
  print(buffer.toString());  // Hello World!
}
```

---

## Conditional Statements

Make decisions in your code.

### 1. if Statement

Execute code only if condition is true.

```dart
void main() {
  int age = 20;
  
  if (age >= 18) {
    print("You are an adult");
  }
  
  // With multiple conditions
  int score = 85;
  
  if (score >= 90) {
    print("Excellent!");
  }
  
  if (score >= 60 && score < 90) {
    print("Good job!");
  }
  
  if (score < 60) {
    print("Need improvement");
  }
}
```

---

### 2. if-else Statement

Choose between two options.

```dart
void main() {
  int temperature = 25;
  
  if (temperature > 30) {
    print("It's hot outside");
  } else {
    print("Weather is nice");
  }
  
  // Check age
  int age = 16;
  
  if (age >= 18) {
    print("Can vote");
  } else {
    print("Too young to vote");
  }
}
```

---

### 3. if-else if-else Statement

Choose between multiple options.

```dart
void main() {
  int score = 85;
  
  if (score >= 90) {
    print("Grade: A");
  } else if (score >= 80) {
    print("Grade: B");
  } else if (score >= 70) {
    print("Grade: C");
  } else if (score >= 60) {
    print("Grade: D");
  } else {
    print("Grade: F");
  }
  
  // Time of day example
  int hour = 14;
  
  if (hour < 12) {
    print("Good morning");
  } else if (hour < 17) {
    print("Good afternoon");
  } else if (hour < 21) {
    print("Good evening");
  } else {
    print("Good night");
  }
}
```

---

### 4. Nested if Statements

Put if statements inside other if statements.

```dart
void main() {
  int age = 25;
  bool hasLicense = true;
  bool hasInsurance = true;
  
  if (age >= 18) {
    print("Age requirement: ✓");
    
    if (hasLicense) {
      print("License: ✓");
      
      if (hasInsurance) {
        print("Insurance: ✓");
        print("You can drive legally!");
      } else {
        print("You need insurance");
      }
    } else {
      print("You need a license");
    }
  } else {
    print("Too young to drive");
  }
}
```

---

### 5. switch Statement

Choose between many options based on a single value.

```dart
void main() {
  String day = "Monday";
  
  switch (day) {
    case "Monday":
      print("Start of work week");
      break;
    case "Tuesday":
    case "Wednesday":
    case "Thursday":
      print("Midweek");
      break;
    case "Friday":
      print("Almost weekend!");
      break;
    case "Saturday":
    case "Sunday":
      print("Weekend!");
      break;
    default:
      print("Invalid day");
  }
  
  // Number example
  int month = 3;
  
  switch (month) {
    case 1:
      print("January");
      break;
    case 2:
      print("February");
      break;
    case 3:
      print("March");
      break;
    default:
      print("Other month");
  }
}
```

**Important:** Always use `break` or the next case will also execute!

---

### 6. switch Expression (Dart 3.0+)

New, cleaner way to use switch.

```dart
void main() {
  String day = "Monday";
  
  // Switch expression - returns a value
  String message = switch (day) {
    "Monday" => "Start of work week",
    "Tuesday" || "Wednesday" || "Thursday" => "Midweek",
    "Friday" => "Almost weekend!",
    "Saturday" || "Sunday" => "Weekend!",
    _ => "Invalid day"
  };
  
  print(message);
  
  // Grade calculator
  int score = 85;
  String grade = switch (score) {
    >= 90 => "A",
    >= 80 => "B",
    >= 70 => "C",
    >= 60 => "D",
    _ => "F"
  };
  
  print("Grade: $grade");
}
```

**Note:** Switch expressions are shorter and don't need `break`.

---

## Loops

Repeat code multiple times.

### 1. for Loop

Repeat a specific number of times.

```dart
void main() {
  // Basic for loop
  print("=== Count to 5 ===");
  for (int i = 1; i <= 5; i++) {
    print("Number: $i");
  }
  
  // Count backwards
  print("\n=== Countdown ===");
  for (int i = 5; i >= 1; i--) {
    print("$i...");
  }
  print("Launch!");
  
  // Skip numbers
  print("\n=== Even numbers ===");
  for (int i = 0; i <= 10; i += 2) {
    print(i);
  }
  
  // Loop through list
  print("\n=== Loop through list ===");
  List<String> fruits = ["Apple", "Banana", "Orange"];
  
  for (int i = 0; i < fruits.length; i++) {
    print("${i + 1}. ${fruits[i]}");
  }
}
```

**for loop structure:**
```dart
for (start; condition; step) {
  // code to repeat
}
```

---

### 2. for-in Loop

Easy way to loop through collections.

```dart
void main() {
  // Loop through list
  List<String> cities = ["Algiers", "Oran", "Constantine"];
  
  for (String city in cities) {
    print("City: $city");
  }
  
  // Loop through set
  Set<int> numbers = {1, 2, 3, 4, 5};
  
  for (int num in numbers) {
    print("Number: $num");
  }
  
  // Loop through string characters
  String name = "Dart";
  
  for (var char in name.split('')) {
    print(char);
  }
}
```

---

### 3. forEach Method

Another way to loop through collections.

```dart
void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // forEach with function
  numbers.forEach((num) {
    print("Number: $num");
  });
  
  // Shorter syntax
  numbers.forEach((num) => print(num * 2));
  
  // Map example
  Map<String, int> ages = {
    "Ali": 25,
    "Sara": 22,
    "Ahmed": 28
  };
  
  ages.forEach((name, age) {
    print("$name is $age years old");
  });
}
```

---

### 4. while Loop

Repeat while condition is true.

```dart
void main() {
  // Count to 5
  int count = 1;
  
  while (count <= 5) {
    print("Count: $count");
    count++;
  }
  
  // User input simulation
  String password = "";
  int attempts = 0;
  
  while (password != "secret" && attempts < 3) {
    print("Attempt ${attempts + 1}: Enter password");
    // password = stdin.readLineSync()!;  // Real input
    password = "wrong";  // Simulated
    attempts++;
  }
  
  if (password == "secret") {
    print("Access granted");
  } else {
    print("Too many attempts");
  }
}
```

**while loop structure:**
```dart
while (condition) {
  // code to repeat
  // don't forget to update condition!
}
```

⚠️ **Warning:** Make sure the condition eventually becomes false, or you'll have an infinite loop!

---

### 5. do-while Loop

Execute at least once, then check condition.

```dart
void main() {
  // Regular while - might not execute
  int count1 = 10;
  while (count1 < 5) {
    print("This never prints");
    count1++;
  }
  
  // do-while - always executes at least once
  int count2 = 10;
  do {
    print("This prints once: $count2");
    count2++;
  } while (count2 < 5);
  
  // Menu example
  String choice;
  int attempts = 0;
  
  do {
    print("\n=== Menu ===");
    print("1. Option 1");
    print("2. Option 2");
    print("3. Exit");
    print("Enter choice:");
    
    choice = "3";  // Simulated input
    attempts++;
  } while (choice != "3" && attempts < 3);
}
```

**Difference between while and do-while:**
- `while`: Check condition first, then execute
- `do-while`: Execute first, then check condition

---

### 6. break Statement

Exit a loop early.

```dart
void main() {
  // Find first even number over 10
  for (int i = 1; i <= 100; i++) {
    if (i > 10 && i % 2 == 0) {
      print("Found: $i");
      break;  // Stop the loop
    }
  }
  
  // Search in list
  List<String> names = ["Ali", "Sara", "Ahmed", "Fatima"];
  String searchName = "Ahmed";
  
  for (String name in names) {
    if (name == searchName) {
      print("Found $name!");
      break;  // No need to continue
    }
  }
}
```

---

### 7. continue Statement

Skip to next iteration.

```dart
void main() {
  // Print only odd numbers
  print("=== Odd numbers 1-10 ===");
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue;  // Skip even numbers
    }
    print(i);
  }
  
  // Skip specific value
  print("\n=== Skip 5 ===");
  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      continue;  // Skip when i is 5
    }
    print(i);
  }
}
```

---

### 8. Nested Loops

Loops inside loops.

```dart
void main() {
  // Multiplication table
  print("=== Multiplication Table ===");
  for (int i = 1; i <= 5; i++) {
    for (int j = 1; j <= 5; j++) {
      print("$i x $j = ${i * j}");
    }
    print("---");
  }
  
  // Print pattern
  print("\n=== Star Pattern ===");
  for (int i = 1; i <= 5; i++) {
    String line = "";
    for (int j = 1; j <= i; j++) {
      line += "* ";
    }
    print(line);
  }
}
```

Output:
```
* 
* * 
* * * 
* * * * 
* * * * * 
```

---

## Functions

Reusable blocks of code.

### 1. Basic Function

```dart
// Function with no parameters, no return
void greet() {
  print("Hello, World!");
}

void main() {
  greet();  // Call the function
  greet();  // Call again
}
```

---

### 2. Function with Parameters

```dart
// Function with parameters
void greetPerson(String name) {
  print("Hello, $name!");
}

void printSum(int a, int b) {
  int sum = a + b;
  print("Sum: $sum");
}

void main() {
  greetPerson("Moussaab");  // Hello, Moussaab!
  greetPerson("Ali");       // Hello, Ali!
  
  printSum(5, 3);  // Sum: 8
  printSum(10, 20); // Sum: 30
}
```

---

### 3. Function with Return Value

```dart
// Return a value
int add(int a, int b) {
  return a + b;
}

String getGreeting(String name) {
  return "Hello, $name!";
}

bool isEven(int number) {
  return number % 2 == 0;
}

void main() {
  int result = add(5, 3);
  print("Result: $result");  // Result: 8
  
  String message = getGreeting("Moussaab");
  print(message);  // Hello, Moussaab!
  
  bool check = isEven(4);
  print("Is 4 even? $check");  // Is 4 even? true
}
```

---

### 4. Arrow Functions (Short Syntax)

For simple one-line functions.

```dart
// Regular function
int addRegular(int a, int b) {
  return a + b;
}

// Arrow function (same thing, shorter)
int addArrow(int a, int b) => a + b;

// More examples
bool isAdult(int age) => age >= 18;
String makeUpper(String text) => text.toUpperCase();
double square(double n) => n * n;

void main() {
  print(addArrow(5, 3));      // 8
  print(isAdult(20));         // true
  print(makeUpper("hello"));  // HELLO
  print(square(4));           // 16.0
}
```

**Rule:** Use `=>` when function is just one expression.

---

### 5. Optional Parameters

#### Named Optional Parameters

```dart
// Named parameters with {}
void printInfo({String? name, int? age, String? city}) {
  print("Name: ${name ?? 'Unknown'}");
  print("Age: ${age ?? 0}");
  print("City: ${city ?? 'Unknown'}");
}

void main() {
  printInfo(name: "Ali", age: 25, city: "Algiers");
  printInfo(name: "Sara");  // age and city will be null
  printInfo();  // All parameters will be null
}
```

#### Required Named Parameters

```dart
// Force certain parameters with 'required'
void createUser({
  required String email,
  required String password,
  String? phone
}) {
  print("Creating user:");
  print("Email: $email");
  print("Password: $password");
  print("Phone: ${phone ?? 'Not provided'}");
}

void main() {
  createUser(
    email: "user@example.com",
    password: "pass123"
  );
  
  // createUser();  // ERROR - email and password are required
}
```

#### Positional Optional Parameters

```dart
// Optional positional parameters with []
void printNumbers(int first, [int? second, int? third]) {
  print("First: $first");
  print("Second: ${second ?? 'Not provided'}");
  print("Third: ${third ?? 'Not provided'}");
}

void main() {
  printNumbers(1);        // Only first
  printNumbers(1, 2);     // First and second
  printNumbers(1, 2, 3);  // All three
}
```

---

### 6. Default Parameter Values

```dart
// Default values for named parameters
void greetUser({
  String name = "Guest",
  String greeting = "Hello"
}) {
  print("$greeting, $name!");
}

// Default values for positional parameters
void printMessage(String text, [String prefix = "INFO"]) {
  print("[$prefix] $text");
}

void main() {
  greetUser();  // Hello, Guest!
  greetUser(name: "Ali");  // Hello, Ali!
  greetUser(name: "Sara", greeting: "Hi");  // Hi, Sara!
  
  printMessage("System started");  // [INFO] System started
  printMessage("Error occurred", "ERROR");  // [ERROR] Error occurred
}
```

---

### 7. Functions Returning Multiple Values (Records)

```dart
// Return multiple values using records
(int, int) getDimensions() {
  return (1920, 1080);
}

(String, int, bool) getUserInfo() {
  return ("Ali", 25, true);
}

// Named record return
({String name, int age, String city}) getPersonDetails() {
  return (name: "Moussaab", age: 25, city: "Algiers");
}

void main() {
  // Get dimensions
  var (width, height) = getDimensions();
  print("Screen: ${width}x$height");
  
  // Get user info
  var (name, age, isActive) = getUserInfo();
  print("User: $name, Age: $age, Active: $isActive");
  
  // Get person details
  var person = getPersonDetails();
  print("${person.name} from ${person.city}");
}
```

---

### 8. Anonymous Functions (Lambda)

Functions without names.

```dart
void main() {
  // Regular anonymous function
  var sayHello = () {
    print("Hello!");
  };
  sayHello();  // Hello!
  
  // Anonymous function with parameters
  var add = (int a, int b) {
    return a + b;
  };
  print(add(5, 3));  // 8
  
  // Arrow syntax
  var multiply = (int a, int b) => a * b;
  print(multiply(4, 5));  // 20
  
  // Use in forEach
  List<int> numbers = [1, 2, 3, 4, 5];
  
  numbers.forEach((num) {
    print("Number: $num");
  });
  
  // Shorter
  numbers.forEach((num) => print(num * 2));
}
```

---

### 9. Higher-Order Functions

Functions that take other functions as parameters.

```dart
// Function that takes another function
void executeOperation(int a, int b, Function(int, int) operation) {
  int result = operation(a, b);
  print("Result: $result");
}

// Functions to pass
int add(int a, int b) => a + b;
int multiply(int a, int b) => a * b;

void main() {
  executeOperation(5, 3, add);       // Result: 8
  executeOperation(5, 3, multiply);  // Result: 15
  
  // With anonymous function
  executeOperation(10, 2, (a, b) => a - b);  // Result: 8
}
```

---

### 10. Recursive Functions

Functions that call themselves.

```dart
// Calculate factorial
int factorial(int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}

// Countdown
void countdown(int n) {
  if (n <= 0) {
    print("Done!");
    return;
  }
  print(n);
  countdown(n - 1);
}

// Sum of numbers 1 to n
int sumToN(int n) {
  if (n <= 0) return 0;
  return n + sumToN(n - 1);
}

void main() {
  print("Factorial of 5: ${factorial(5)}");  // 120
  
  countdown(5);  // 5, 4, 3, 2, 1, Done!
  
  print("Sum 1 to 10: ${sumToN(10)}");  // 55
}
```

---

## Practice Examples

### Example 1: Calculator

```dart
void main() {
  print("=== Simple Calculator ===\n");
  
  double result1 = calculate(10, 5, '+');
  double result2 = calculate(10, 5, '-');
  double result3 = calculate(10, 5, '*');
  double result4 = calculate(10, 5, '/');
  
  print("10 + 5 = $result1");
  print("10 - 5 = $result2");
  print("10 * 5 = $result3");
  print("10 / 5 = $result4");   