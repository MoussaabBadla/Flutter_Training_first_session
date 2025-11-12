# Dart Null Safety & Asynchronous Programming

**Complete Guide to Null Safety, Futures, Streams & Async Programming**

---

## Table of Contents

1. [Null Safety](#null-safety)
2. [Terminology](#terminology)
3. [Futures](#futures)
4. [Async/Await](#asyncawait)
5. [Streams](#streams)
6. [Error Handling](#error-handling)
7. [Advanced Async Patterns](#advanced-async-patterns)
8. [Practice Examples](#practice-examples)

---

## Null Safety

Dart's null safety prevents null reference errors at compile time.

### Understanding Null Safety

```dart
void main() {
  // Non-nullable type - cannot be null
  String name = "Moussaab";
  // name = null;  // ERROR - can't assign null
  
  // Nullable type - can be null
  String? nickname;  // Automatically null
  nickname = "Mo";
  nickname = null;   // OK
  
  // Non-nullable with initialization
  int age = 25;
  
  // Nullable without initialization
  int? score;  // null by default
  
  print(name);      // Moussaab
  print(nickname);  // null
  print(age);       // 25
  print(score);     // null
}
```

### Null Safety Operators

#### 1. Null-aware Access (`?.`)

```dart
class User {
  String name;
  String? email;  // Optional
  
  User(this.name, [this.email]);
}

void main() {
  User user1 = User("Ali", "ali@example.com");
  User user2 = User("Sara");  // No email
  
  // Null-aware access
  print(user1.email?.length);  // 15
  print(user2.email?.length);  // null (not error!)
  
  // Without ?. would cause error
  // print(user2.email.length);  // ERROR if email is null
}
```

#### 2. Null-aware Assignment (`??=`)

```dart
void main() {
  String? name;
  
  // Assign only if null
  name ??= "Default Name";
  print(name);  // Default Name
  
  name ??= "Another Name";
  print(name);  // Default Name (not changed)
  
  // Another example
  int? count;
  count ??= 0;
  count++;
  print(count);  // 1
}
```

#### 3. Null Coalescing (`??`)

```dart
void main() {
  String? username;
  
  // Use value if not null, otherwise use default
  String display = username ?? "Guest";
  print(display);  // Guest
  
  username = "Moussaab";
  display = username ?? "Guest";
  print(display);  // Moussaab
  
  // Chaining
  String? firstName;
  String? lastName;
  String? nickname;
  
  String name = firstName ?? lastName ?? nickname ?? "Anonymous";
  print(name);  // Anonymous
}
```

#### 4. Null Assertion (`!`)

```dart
void main() {
  String? maybeValue = "Hello";
  
  // Assert that value is not null
  String definiteValue = maybeValue!;
  print(definiteValue);  // Hello
  
  // BE CAREFUL! This will crash if null
  String? nullValue;
  // String crash = nullValue!;  // Runtime error!
  
  // Use only when you're absolutely sure it's not null
}
```

#### 5. Late Variables

```dart
// Late variable - initialized later
late String description;

class Database {
  late final String connection;
  
  Database() {
    // Initialize in constructor
    connection = "mongodb://localhost:27017";
  }
}

void main() {
  // Must initialize before use
  description = "This is a description";
  print(description);  // This is a description
  
  // Using late with class
  Database db = Database();
  print(db.connection);  // mongodb://localhost:27017
  
  // Late with initialization
  late String computed = expensiveOperation();
  // expensiveOperation() only called when 'computed' is accessed
}

String expensiveOperation() {
  print("Computing...");
  return "Result";
}
```

### Null Safety Patterns

#### Pattern 1: Checking for Null

```dart
void processUser(String? email) {
  // Method 1: if-null check
  if (email != null) {
    print("Email length: ${email.length}");
    print("Uppercase: ${email.toUpperCase()}");
  } else {
    print("No email provided");
  }
  
  // Method 2: Using ??
  print("Email: ${email ?? 'not provided'}");
}

void main() {
  processUser("test@example.com");
  processUser(null);
}
```

#### Pattern 2: Type Promotion

```dart
void checkValue(String? value) {
  // Before check: value is String?
  
  if (value != null) {
    // Inside block: value is promoted to String (non-nullable)
    print(value.length);      // OK
    print(value.toUpperCase()); // OK
  }
  
  // Outside block: value is String? again
  // print(value.length);  // ERROR
}

void main() {
  checkValue("Hello");
  checkValue(null);
}
```

#### Pattern 3: Default Values with Functions

```dart
class Config {
  String? host;
  int? port;
  
  Config({this.host, this.port});
  
  String getHost() => host ?? "localhost";
  int getPort() => port ?? 8080;
}

void main() {
  Config config1 = Config(host: "192.168.1.1", port: 3000);
  print("${config1.getHost()}:${config1.getPort()}");
  
  Config config2 = Config();
  print("${config2.getHost()}:${config2.getPort()}");
}
```

---

## Terminology

### Key Terms in Async Programming

| Term | Definition | Example |
|------|------------|---------|
| **Synchronous** | Code executes line by line, blocking | `print("Hello")` |
| **Asynchronous** | Code that can run independently | `Future`, `Stream` |
| **Future** | Represents a value that will be available later | `Future<String>` |
| **Promise** | Another name for Future (from JS) | Same as Future |
| **Stream** | Sequence of async events over time | `Stream<int>` |
| **async** | Marks function as asynchronous | `async { }` |
| **await** | Waits for Future to complete | `await future` |
| **Event Loop** | Handles async operations | Dart runtime |
| **Microtask** | High-priority async task | `scheduleMicrotask()` |
| **Isolate** | Independent worker (like thread) | `Isolate.spawn()` |
| **Completer** | Manual Future controller | `Completer<T>()` |
| **Callback** | Function passed as argument | `then((value) {})` |
| **Error Handling** | Managing async errors | `try-catch`, `catchError` |

### Visual Representation

```
SYNCHRONOUS (Blocking):
Task 1 ████████
         Task 2 ████████
                  Task 3 ████████
Time ────────────────────────────────────►

ASYNCHRONOUS (Non-blocking):
Task 1 ████████
Task 2 ████████
Task 3 ████████
Time ───────────►
```

---

## Futures

A Future represents a value that will be available in the future.

### Understanding Futures

```dart
void main() {
  print("Start");
  
  // Future completes after 2 seconds
  Future<String> futureData = Future.delayed(
    Duration(seconds: 2),
    () => "Data loaded!",
  );
  
  print("Waiting for data...");
  
  // Continue with other code (non-blocking)
  print("Doing other work...");
  
  // This completes immediately
  print("End of main");
  
  // The future completes after 2 seconds
}
```

### Creating Futures

```dart
// Method 1: Future.delayed
Future<String> fetchUserDelayed() {
  return Future.delayed(
    Duration(seconds: 2),
    () => "User: Moussaab",
  );
}

// Method 2: Future.value (immediate)
Future<int> getNumberImmediate() {
  return Future.value(42);
}

// Method 3: Future.error
Future<String> getError() {
  return Future.error("Something went wrong!");
}

// Method 4: Async function (recommended)
Future<String> fetchUser() async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 1));
  return "User: Ali";
}

void main() async {
  print("Fetching user...");
  String user = await fetchUser();
  print(user);
}
```

### Using Future.then()

```dart
Future<String> fetchData() {
  return Future.delayed(
    Duration(seconds: 2),
    () => "API Response",
  );
}

void main() {
  print("Start");
  
  fetchData().then((data) {
    // Executes when future completes
    print("Received: $data");
  });
  
  print("End");
  // Output order:
  // Start
  // End
  // (2 seconds later)
  // Received: API Response
}
```

### Chaining Futures

```dart
Future<String> fetchUser() {
  return Future.delayed(Duration(seconds: 1), () => "UserID: 123");
}

Future<String> fetchUserDetails(String userId) {
  return Future.delayed(
    Duration(seconds: 1),
    () => "Details for $userId",
  );
}

Future<String> fetchUserPosts(String details) {
  return Future.delayed(
    Duration(seconds: 1),
    () => "Posts for $details",
  );
}

void main() {
  print("Start fetching...");
  
  fetchUser()
      .then((user) {
        print("1. Got: $user");
        return fetchUserDetails(user);
      })
      .then((details) {
        print("2. Got: $details");
        return fetchUserPosts(details);
      })
      .then((posts) {
        print("3. Got: $posts");
      })
      .catchError((error) {
        print("Error: $error");
      });
}
```

### Future.wait() - Multiple Futures

```dart
Future<String> fetchData1() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data 1";
}

Future<String> fetchData2() async {
  await Future.delayed(Duration(seconds: 1));
  return "Data 2";
}

Future<String> fetchData3() async {
  await Future.delayed(Duration(seconds: 3));
  return "Data 3";
}

void main() async {
  print("Fetching all data...");
  
  // Wait for all futures to complete
  List<String> results = await Future.wait([
    fetchData1(),
    fetchData2(),
    fetchData3(),
  ]);
  
  print("All done!");
  print(results);  // [Data 1, Data 2, Data 3]
  // Takes 3 seconds (not 6) - parallel execution!
}
```

### Future.any() - First to Complete

```dart
Future<String> server1() async {
  await Future.delayed(Duration(seconds: 2));
  return "Response from Server 1";
}

Future<String> server2() async {
  await Future.delayed(Duration(seconds: 1));
  return "Response from Server 2";
}

Future<String> server3() async {
  await Future.delayed(Duration(seconds: 3));
  return "Response from Server 3";
}

void main() async {
  print("Requesting from multiple servers...");
  
  // Returns first completed future
  String response = await Future.any([
    server1(),
    server2(),
    server3(),
  ]);
  
  print(response);  // Response from Server 2 (fastest)
}
```

---

## Async/Await

Modern, readable way to work with Futures.

### Basic Async/Await

```dart
// Without async/await (callback hell)
void fetchDataOldWay() {
  fetchUser().then((user) {
    print(user);
    fetchPosts().then((posts) {
      print(posts);
      fetchComments().then((comments) {
        print(comments);
      });
    });
  });
}

// With async/await (clean and readable)
Future<void> fetchDataNewWay() async {
  String user = await fetchUser();
  print(user);
  
  String posts = await fetchPosts();
  print(posts);
  
  String comments = await fetchComments();
  print(comments);
}

Future<String> fetchUser() async {
  await Future.delayed(Duration(seconds: 1));
  return "User Data";
}

Future<String> fetchPosts() async {
  await Future.delayed(Duration(seconds: 1));
  return "Posts Data";
}

Future<String> fetchComments() async {
  await Future.delayed(Duration(seconds: 1));
  return "Comments Data";
}

void main() async {
  await fetchDataNewWay();
}
```

### Async Function Return Types

```dart
// Returns Future<String>
Future<String> getString() async {
  return "Hello";
}

// Returns Future<int>
Future<int> getNumber() async {
  return 42;
}

// Returns Future<void> (no value)
Future<void> doSomething() async {
  print("Doing something...");
  await Future.delayed(Duration(seconds: 1));
  print("Done!");
}

// Returns Future<List<String>>
Future<List<String>> getList() async {
  await Future.delayed(Duration(seconds: 1));
  return ["Item 1", "Item 2", "Item 3"];
}

void main() async {
  String str = await getString();
  print(str);
  
  int num = await getNumber();
  print(num);
  
  await doSomething();
  
  List<String> list = await getList();
  print(list);
}
```

### Sequential vs Parallel Execution

```dart
Future<String> task1() async {
  await Future.delayed(Duration(seconds: 2));
  return "Task 1 Done";
}

Future<String> task2() async {
  await Future.delayed(Duration(seconds: 2));
  return "Task 2 Done";
}

Future<String> task3() async {
  await Future.delayed(Duration(seconds: 2));
  return "Task 3 Done";
}

// Sequential (6 seconds total)
Future<void> runSequential() async {
  print("Sequential start");
  var start = DateTime.now();
  
  String result1 = await task1();
  String result2 = await task2();
  String result3 = await task3();
  
  var duration = DateTime.now().difference(start);
  print("Sequential done in ${duration.inSeconds}s");
  print("$result1, $result2, $result3");
}

// Parallel (2 seconds total)
Future<void> runParallel() async {
  print("\nParallel start");
  var start = DateTime.now();
  
  // Start all at once
  List<String> results = await Future.wait([
    task1(),
    task2(),
    task3(),
  ]);
  
  var duration = DateTime.now().difference(start);
  print("Parallel done in ${duration.inSeconds}s");
  print(results);
}

void main() async {
  await runSequential();  // Takes ~6 seconds
  await runParallel();    // Takes ~2 seconds
}
```

---

## Streams

Streams deliver multiple values over time, like a pipe of data.

### Understanding Streams

```dart
void main() async {
  // Stream that emits numbers 0-4 with 1 second delay
  Stream<int> numberStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => count,
  ).take(5);
  
  print("Listening to stream...");
  
  // Listen to stream
  await for (int number in numberStream) {
    print("Received: $number");
  }
  
  print("Stream finished");
}
```

### Creating Streams

```dart
// Method 1: Stream.periodic
Stream<int> counterStream() {
  return Stream.periodic(
    Duration(seconds: 1),
    (count) => count,
  ).take(5);
}

// Method 2: Stream.fromIterable
Stream<String> namesStream() {
  return Stream.fromIterable(['Ali', 'Sara', 'Ahmed', 'Fatima']);
}

// Method 3: Stream.fromFuture
Stream<String> dataStream() {
  return Stream.fromFuture(
    Future.delayed(Duration(seconds: 2), () => "Data loaded"),
  );
}

// Method 4: async* generator
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  // Emit value to stream
  }
}

void main() async {
  print("Names Stream:");
  await for (String name in namesStream()) {
    print("- $name");
  }
  
  print("\nCount Stream:");
  await for (int num in countStream(3)) {
    print("Count: $num");
  }
}
```

### Stream Operations

```dart
Stream<int> numberStream() async* {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}

void main() async {
  // map - transform values
  print("Squared numbers:");
  await for (int squared in numberStream().map((n) => n * n)) {
    print(squared);
  }
  
  // where - filter values
  print("\nEven numbers:");
  await for (int even in numberStream().where((n) => n % 2 == 0)) {
    print(even);
  }
  
  // take - limit values
  print("\nFirst 3 numbers:");
  await for (int num in numberStream().take(3)) {
    print(num);
  }
  
  // skip - skip values
  print("\nSkip first 5:");
  await for (int num in numberStream().skip(5)) {
    print(num);
  }
}
```

### Stream Controller

Manual control over streams.

```dart
import 'dart:async';

void main() async {
  // Create stream controller
  StreamController<String> controller = StreamController<String>();
  
  // Listen to stream
  controller.stream.listen(
    (data) => print("Received: $data"),
    onError: (error) => print("Error: $error"),
    onDone: () => print("Stream closed"),
  );
  
  // Add data to stream
  controller.add("Message 1");
  await Future.delayed(Duration(seconds: 1));
  
  controller.add("Message 2");
  await Future.delayed(Duration(seconds: 1));
  
  controller.add("Message 3");
  await Future.delayed(Duration(seconds: 1));
  
  // Close stream
  controller.close();
}
```

### Broadcast Stream

Multiple listeners on same stream.

```dart
import 'dart:async';

void main() async {
  // Regular stream - single listener only
  StreamController<int> controller = StreamController<int>.broadcast();
  
  // Listener 1
  controller.stream.listen((data) {
    print("Listener 1: $data");
  });
  
  // Listener 2
  controller.stream.listen((data) {
    print("Listener 2: $data");
  });
  
  // Add data
  controller.add(1);
  await Future.delayed(Duration(seconds: 1));
  
  controller.add(2);
  await Future.delayed(Duration(seconds: 1));
  
  controller.add(3);
  
  controller.close();
}
```

### StreamTransformer

Transform stream data.

```dart
import 'dart:async';

void main() async {
  // Create transformer
  StreamTransformer<int, String> transformer = 
      StreamTransformer.fromHandlers(
    handleData: (int data, EventSink<String> sink) {
      // Transform int to String
      sink.add("Number: $data");
    },
  );
  
  // Create stream
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);
  
  // Apply transformer
  Stream<String> transformed = numbers.transform(transformer);
  
  // Listen
  await for (String text in transformed) {
    print(text);
  }
}
```

---

## Error Handling

Handle errors in async code.

### Try-Catch with Async/Await

```dart
Future<String> fetchData({bool shouldFail = false}) async {
  await Future.delayed(Duration(seconds: 1));
  
  if (shouldFail) {
    throw Exception("Failed to fetch data");
  }
  
  return "Success data";
}

Future<void> handleErrors() async {
  try {
    String data = await fetchData(shouldFail: false);
    print("Success: $data");
  } catch (e) {
    print("Error caught: $e");
  } finally {
    print("Cleanup done");
  }
}

void main() async {
  await handleErrors();
  
  print("\nTrying with error:");
  try {
    String data = await fetchData(shouldFail: true);
    print("Success: $data");
  } catch (e) {
    print("Error caught: $e");
  }
}
```

### catchError with Futures

```dart
Future<String> riskyOperation() {
  return Future.delayed(
    Duration(seconds: 1),
    () => throw Exception("Something went wrong!"),
  );
}

void main() {
  riskyOperation()
      .then((data) {
        print("Success: $data");
      })
      .catchError((error) {
        print("Error: $error");
      })
      .whenComplete(() {
        print("Operation complete");
      });
}
```

### Error Handling with Streams

```dart
import 'dart:async';

Stream<int> numberStreamWithError() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    
    if (i == 3) {
      throw Exception("Error at number 3");
    }
    
    yield i;
  }
}

void main() async {
  try {
    await for (int number in numberStreamWithError()) {
      print("Number: $number");
    }
  } catch (e) {
    print("Stream error: $e");
  }
  
  print("\nUsing listen with error handler:");
  
  numberStreamWithError().listen(
    (number) => print("Number: $number"),
    onError: (error) => print("Error: $error"),
    onDone: () => print("Stream done"),
  );
  
  // Keep program running
  await Future.delayed(Duration(seconds: 6));
}
```

---

## Advanced Async Patterns

### Pattern 1: Timeout

```dart
Future<String> slowOperation() async {
  await Future.delayed(Duration(seconds: 5));
  return "Finally done!";
}

void main() async {
  try {
    // Timeout after 2 seconds
    String result = await slowOperation().timeout(
      Duration(seconds: 2),
      onTimeout: () {
        throw TimeoutException("Operation took too long");
      },
    );
    print(result);
  } catch (e) {
    print("Error: $e");
  }
}
```

### Pattern 2: Retry Logic

```dart
Future<String> unreliableOperation() async {
  // 70% chance of failure
  await Future.delayed(Duration(seconds: 1));
  
  if (DateTime.now().millisecond % 10 < 7) {
    throw Exception("Operation failed");
  }
  
  return "Success!";
}

Future<String> retryOperation(int maxAttempts) async {
  for (int attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      print("Attempt $attempt...");
      String result = await unreliableOperation();
      return result;
    } catch (e) {
      if (attempt == maxAttempts) {
        throw Exception("Failed after $maxAttempts attempts");
      }
      print("Failed, retrying...");
      await Future.delayed(Duration(seconds: 1));
    }
  }
  throw Exception("Should not reach here");
}

void main() async {
  try {
    String result = await retryOperation(5);
    print("Result: $result");
  } catch (e) {
    print("Error: $e");
  }
}
```

### Pattern 3: Debouncing

```dart
import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;
  
  Debouncer({required this.delay});
  
  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
  
  void dispose() {
    _timer?.cancel();
  }
}

void main() async {
  Debouncer debouncer = Debouncer(delay: Duration(seconds: 2));
  
  // Simulate rapid user input
  print("User typing...");
  debouncer.call(() => print("Search: h"));
  await Future.delayed(Duration(milliseconds: 500));
  
  debouncer.call(() => print("Search: he"));
  await Future.delayed(Duration(milliseconds: 500));
  
  debouncer.call(() => print("Search: hel"));
  await Future.delayed(Duration(milliseconds: 500));
  
  debouncer.call(() => print("Search: hello"));
  // Only this last call executes after 2 seconds
  
  await Future.delayed(Duration(seconds: 3));
  debouncer.dispose();
}
```

### Pattern 4: Throttling

```dart
import 'dart:async';

class Throttler {
  final Duration interval;
  bool _isThrottled = false;
  
  Throttler({required this.interval});
  
  Future<void> call(Future<void> Function() action) async {
    if (_isThrottled) return;
    
    _isThrottled = true;
    await action();
    
    Timer(interval, () {
      _isThrottled = false;
    });
  }
}

void main() async {
  Throttler throttler = Throttler(interval: Duration(seconds: 2));
  
  // Rapid calls
  for (int i = 1; i <= 10; i++) {
    throttler.call(() async {
      print("API call $i at ${DateTime.now().second}s");
    });
    await Future.delayed(Duration(milliseconds: 300));
  }
  
  await Future.delayed(Duration(seconds: 5));
}
```

### Pattern 5: Completer

```dart
import 'dart:async';

class DataLoader {
  final Completer<String> _completer = Completer<String>();
  
  Future<String> get data => _completer.future;
  
  void startLoading() {
    print("Loading started...");
    
    // Simulate async operation
    Future.delayed(Duration(seconds: 2), () {
      // Complete the future manually
      _completer.complete("Data loaded successfully");
    });
  }
  
  void failLoading() {
    _completer.completeError("Loading failed");
  }
}

void main() async {
  DataLoader loader = DataLoader();
  
  // Start loading
  loader.startLoading();
  
  // Wait for data
  try {
    String result = await loader.data;
    print(result);
  } catch (e) {
    print("Error: $e");
  }
}
```

---

## Practice Examples

### Example 1: Weather API Simulation

```dart
class Weather {
  String city;
  double temperature;
  String condition;
  
  Weather(this.city, this.temperature, this.condition);
  
  @override
  String toString() {
    return "$city: $temperature°C, $condition";
  }
}

Future<Weather> fetchWeather(String city) async {
  print("Fetching weather for $city...");
  
  // Simulate API delay
  await Future.delayed(Duration(seconds: 2));
  
  // Simulate random temperature
  double temp = 15 + (DateTime.now().millisecond % 20);
  String condition = temp > 25 ? "Sunny" : "Cloudy";
  
  return Weather(city, temp, condition);
}

Future<void> getWeatherForCities() async {
  List<String> cities = ["Algiers", "Paris", "London", "Berlin"];
  
  try {
    // Fetch all weather data in parallel
    List<Weather> weatherList = await Future.wait(
      cities.map((city) => fetchWeather(city)),
    );
    
    print("\n=== Weather Report ===");
    for (var weather in weatherList) {
      print(weather);
    }
  } catch (e) {
    print("Error fetching weather: $e");
  }
}

void main() async {
  await getWeatherForCities();
}
```

### Example 2: Real-time Chat Stream

```dart
import 'dart:async';

class ChatMessage {
  String sender;
  String message;
  DateTime timestamp;
  
  ChatMessage(this.sender, this.message)
      : timestamp = DateTime.now();
  
  @override
  String toString() {
    return "[$sender]: $message";
  }
}

class ChatRoom {
  final StreamController<ChatMessage> _controller =
      StreamController<ChatMessage>.broadcast();
  
  Stream<ChatMessage> get messages => _controller.stream;
  
  void sendMessage(String sender, String message) {
    _controller.add(ChatMessage(sender, message));
  }
  
  void close() {
    _controller.close();
  }
}

void main() async {
  ChatRoom chatRoom = ChatRoom();
  
  // User 1 listening
  chatRoom.messages.listen((message) {
    print("[User1 received] $message");
  });
  
  // User 2 listening
  chatRoom.messages.listen((message) {
    print("[User2 received] $message");
  });
  
  // Send messages
  chatRoom.sendMessage("Alice", "Hello everyone!");
  await Future.delayed(Duration(seconds: 1));
  
  chatRoom.sendMessage("Bob", "Hi Alice!");
  await Future.delayed(Duration(seconds: 1));
  
  chatRoom.sendMessage("Alice", "How are you?");
  await Future.delayed(Duration(seconds: 1));
  
  chatRoom.close();
}
```

### Example 3: File Download Simulator

```dart
import 'dart:async';

class DownloadManager {
  Stream<int> downloadFile(String filename, int totalSize) async* {
    print("Starting download: $filename");
    int downloaded = 0;
    int chunkSize = totalSize ~/ 10; // 10 chunks
    
    while (downloaded < totalSize) {
      // Simulate download delay
      await Future.delayed(Duration(milliseconds: 500));
      
      downloaded += chunkSize;
      if (downloaded > totalSize) downloaded = totalSize;
      
      // Calculate progress percentage
      int progress = ((downloaded / totalSize) * 100).round();
      
      yield progress;
    }
    
    print("Download complete: $filename");
  }
}

void main() async {
  DownloadManager manager = DownloadManager();
  
  print("=== File Download ===");
  await for (int progress in manager.downloadFile("video.mp4", 1000000)) {
    print("Progress: $progress%");
  }
  
  print("\n=== Multiple Downloads ===");
  
  // Download multiple files in parallel
  Stream<int> download1 = manager.downloadFile("file1.zip", 500000);
  Stream<int> download2 = manager.downloadFile("file2.pdf", 300000);
  
  // Listen to both streams
  download1.listen((progress) => print("File1: $progress%"));
  download2.listen((progress) => print("File2: $progress%"));
  
  // Wait for completion
  await Future.delayed(Duration(seconds: 6));
}
```

### Example 4: User Authentication Flow

```dart
import 'dart:async';

class User {
  String username;
  String email;
  String? token;
  
  User(this.username, this.email, [this.token]);
}

class AuthService {
  // Simulate login
  Future<User> login(String username, String password) async {
    print("Logging in...");
    await Future.delayed(Duration(seconds: 2));
    
    if (password == "wrong") {
      throw Exception("Invalid credentials");
    }
    
    String token = "token_${DateTime.now().millisecondsSinceEpoch}";
    return User(username, "$username@example.com", token);
  }
  
  // Simulate fetching user profile
  Future<Map<String, dynamic>> fetchProfile(String token) async {
    print("Fetching profile...");
    await Future.delayed(Duration(seconds: 1));
    
    return {
      'name': 'Moussaab',
      'age': 25,
      'location': 'Algiers',
      'premium': true,
    };
  }
  
  // Simulate logout
  Future<void> logout(String token) async {
    print("Logging out...");
    await Future.delayed(Duration(seconds: 1));
    print("Logged out successfully");
  }
}

void main() async {
  AuthService auth = AuthService();
  
  try {
    // Login
    User user = await auth.login("moussaab", "correct123");
    print("Logged in: ${user.username}");
    print("Token: ${user.token}");
    
    // Fetch profile
    Map<String, dynamic> profile = await auth.fetchProfile(user.token!);
    print("\nProfile:");
    profile.forEach((key, value) {
      print("  $key: $value");
    });
    
    // Logout
    await auth.logout(user.token!);
    
  } catch (e) {
    print("Authentication error: $e");
  }
}
```

### Example 5: Task Queue with Streams

```dart
import 'dart:async';

class Task {
  String name;
  int duration; // seconds
  
  Task(this.name, this.duration);
  
  Future<String> execute() async {
    print("Starting task: $name");
    await Future.delayed(Duration(seconds: duration));
    return "$name completed!";
  }
}

class TaskQueue {
  final StreamController<Task> _inputController = StreamController<Task>();
  final StreamController<String> _outputController = StreamController<String>();
  
  Stream<String> get results => _outputController.stream;
  
  TaskQueue() {
    _inputController.stream.listen((task) async {
      try {
        String result = await task.execute();
        _outputController.add(result);
      } catch (e) {
        _outputController.addError("Task ${task.name} failed: $e");
      }
    });
  }
  
  void addTask(Task task) {
    _inputController.add(task);
  }
  
  void close() {
    _inputController.close();
    _outputController.close();
  }
}

void main() async {
  TaskQueue queue = TaskQueue();
  
  // Listen to results
  queue.results.listen(
    (result) => print("✓ $result"),
    onError: (error) => print("✗ $error"),
  );
  
  // Add tasks
  queue.addTask(Task("Download file", 2));
  queue.addTask(Task("Process data", 1));
  queue.addTask(Task("Upload results", 3));
  queue.addTask(Task("Send notification", 1));
  
  // Wait for all tasks
  await Future.delayed(Duration(seconds: 8));
  
  queue.close();
}
```

### Example 6: Cache with Timeout

```dart
class CacheEntry<T> {
  T value;
  DateTime timestamp;
  
  CacheEntry(this.value) : timestamp = DateTime.now();
  
  bool isExpired(Duration maxAge) {
    return DateTime.now().difference(timestamp) > maxAge;
  }
}

class Cache<T> {
  final Map<String, CacheEntry<T>> _cache = {};
  final Duration maxAge;
  
  Cache({this.maxAge = const Duration(minutes: 5)});
  
  Future<T> get(
    String key,
    Future<T> Function() fetcher,
  ) async {
    // Check cache
    if (_cache.containsKey(key)) {
      CacheEntry<T> entry = _cache[key]!;
      
      if (!entry.isExpired(maxAge)) {
        print("Cache HIT: $key");
        return entry.value;
      } else {
        print("Cache EXPIRED: $key");
        _cache.remove(key);
      }
    }
    
    // Cache miss - fetch data
    print("Cache MISS: $key - Fetching...");
    T value = await fetcher();
    
    // Store in cache
    _cache[key] = CacheEntry<T>(value);
    
    return value;
  }
  
  void clear() {
    _cache.clear();
    print("Cache cleared");
  }
}

// Simulate API call
Future<String> fetchUserData(String userId) async {
  await Future.delayed(Duration(seconds: 2));
  return "User data for $userId";
}

void main() async {
  Cache<String> cache = Cache(maxAge: Duration(seconds: 5));
  
  // First call - cache miss
  String data1 = await cache.get(
    "user_123",
    () => fetchUserData("user_123"),
  );
  print("Result: $data1\n");
  
  // Second call - cache hit
  String data2 = await cache.get(
    "user_123",
    () => fetchUserData("user_123"),
  );
  print("Result: $data2\n");
  
  // Wait for expiration
  print("Waiting for cache to expire...");
  await Future.delayed(Duration(seconds: 6));
  
  // Third call - cache expired
  String data3 = await cache.get(
    "user_123",
    () => fetchUserData("user_123"),
  );
  print("Result: $data3");
}
```

### Example 7: Rate Limiter

```dart
import 'dart:async';

class RateLimiter {
  final int maxRequests;
  final Duration window;
  final Queue<DateTime> _requests = Queue<DateTime>();
  
  RateLimiter({
    required this.maxRequests,
    required this.window,
  });
  
  Future<T> execute<T>(Future<T> Function() action) async {
    await _waitIfNeeded();
    
    _requests.add(DateTime.now());
    return await action();
  }
  
  Future<void> _waitIfNeeded() async {
    // Remove old requests outside window
    DateTime now = DateTime.now();
    _requests.removeWhere(
      (time) => now.difference(time) > window,
    );
    
    // Check if we need to wait
    if (_requests.length >= maxRequests) {
      DateTime oldest = _requests.first;
      Duration waitTime = window - now.difference(oldest);
      
      print("Rate limit reached. Waiting ${waitTime.inSeconds}s...");
      await Future.delayed(waitTime);
      
      // Clean up again after waiting
      _requests.removeWhere(
        (time) => DateTime.now().difference(time) > window,
      );
    }
  }
}

class Queue<T> {
  final List<T> _list = [];
  
  void add(T item) => _list.add(item);
  T get first => _list.first;
  int get length => _list.length;
  void removeWhere(bool Function(T) test) => _list.removeWhere(test);
}

Future<String> apiCall(int requestNumber) async {
  print("Making request #$requestNumber...");
  await Future.delayed(Duration(milliseconds: 100));
  return "Response #$requestNumber";
}

void main() async {
  // Allow 3 requests per 5 seconds
  RateLimiter limiter = RateLimiter(
    maxRequests: 3,
    window: Duration(seconds: 5),
  );
  
  // Make 7 requests (will be rate limited)
  for (int i = 1; i <= 7; i++) {
    String response = await limiter.execute(() => apiCall(i));
    print("Received: $response\n");
  }
}
```

---

## Best Practices & Tips

### 1. Always Handle Errors

```dart
// ✗ BAD - No error handling
Future<void> badExample() async {
  String data = await riskyOperation();
  print(data);
}

// ✓ GOOD - With error handling
Future<void> goodExample() async {
  try {
    String data = await riskyOperation();
    print(data);
  } catch (e) {
    print("Error: $e");
  }
}

Future<String> riskyOperation() async {
  throw Exception("Failed");
}
```

### 2. Use Timeouts for Network Calls

```dart
Future<String> fetchWithTimeout() async {
  return await fetchData().timeout(
    Duration(seconds: 10),
    onTimeout: () => throw TimeoutException("Request timeout"),
  );
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 15));
  return "Data";
}
```

### 3. Cancel Streams When Done

```dart
void main() async {
  StreamController<int> controller = StreamController<int>();
  
  // Listen with subscription
  StreamSubscription subscription = controller.stream.listen((data) {
    print("Data: $data");
  });
  
  // Add data
  controller.add(1);
  controller.add(2);
  
  // Cancel when done
  await subscription.cancel();
  controller.close();
}
```

### 4. Use Async/Await Over .then()

```dart
// ✗ BAD - Callback hell
void badExample() {
  fetchUser().then((user) {
    fetchPosts(user).then((posts) {
      fetchComments(posts).then((comments) {
        print(comments);
      });
    });
  });
}

// ✓ GOOD - Clean async/await
Future<void> goodExample() async {
  User user = await fetchUser();
  Posts posts = await fetchPosts(user);
  Comments comments = await fetchComments(posts);
  print(comments);
}
```

### 5. Parallel When Possible

```dart
// ✗ SLOW - Sequential (6 seconds)
Future<void> sequential() async {
  var data1 = await fetch1(); // 2s
  var data2 = await fetch2(); // 2s
  var data3 = await fetch3(); // 2s
}

// ✓ FAST - Parallel (2 seconds)
Future<void> parallel() async {
  var results = await Future.wait([
    fetch1(),
    fetch2(),
    fetch3(),
  ]);
}

Future<String> fetch1() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data 1";
}

Future<String> fetch2() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data 2";
}

Future<String> fetch3() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data 3";
}
```

---

## Summary

### Null Safety Quick Reference

| Operator | Usage | Description |
|----------|-------|-------------|
| `?` | `String?` | Nullable type |
| `!` | `value!` | Null assertion |
| `?.` | `obj?.method()` | Null-aware access |
| `??` | `value ?? default` | Null coalescing |
| `??=` | `value ??= default` | Null-aware assignment |
| `late` | `late String x` | Late initialization |

### Async Keywords

| Keyword | Usage | Description |
|---------|-------|-------------|
| `Future<T>` | `Future<String>` | Value available later |
| `async` | `async { }` | Async function marker |
| `await` | `await future` | Wait for Future |
| `Stream<T>` | `Stream<int>` | Multiple values over time |
| `async*` | `async* { }` | Stream generator |
| `yield` | `yield value` | Emit to stream |

### Common Patterns

1. **Sequential**: Use `await` for dependent operations
2. **Parallel**: Use `Future.wait()` for independent operations
3. **First Result**: Use `Future.any()` for race conditions
4. **Timeout**: Use `.timeout()` for time limits
5. **Retry**: Wrap in loop with try-catch
6. **Debounce**: Delay action until pause
7. **Throttle**: Limit action frequency
8. **Cache**: Store results temporarily

### Remember

- Always handle errors with try-catch
- Use timeouts for network operations
- Cancel streams and subscriptions
- Prefer async/await over callbacks
- Run independent operations in parallel
- Close StreamControllers when done
- Test both success and error cases
- Use null safety to prevent runtime errors