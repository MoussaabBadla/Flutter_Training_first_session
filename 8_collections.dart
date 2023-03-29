void main() {
  List<int> ages = [10, 30, 23];
// String List
  List<String> names = ["Raj", "John", "Rocky"];
// Mixed List
  var mixed = [10, "John", 18.8];

  names[1] = "Bill"; // possible
  names[2] = "Elon"; // possible

  const List<String> names2 = ["Raj", "John", "Rocky"]; // Immutable List
  names[1] = "Bill"; // not possible
  names[2] = "Elon"; // not possible
// first: It returns the first element in the List.
// last: It returns the last element in the List.
// isEmpty: It returns true if the List is empty and false if the List is not empty.
// isNotEmpty: It returns true if the List is not empty and false if the List is empty.
// length: It returns the length of the List.
// reversed: It returns a List in reverse order.
// single: It is used to check if the List has only one element and returns it.

  Set<String> fruits = {"Apple", "Orange", "Mango"};
  print(fruits);

  // print("First Value is ${fruits.first}");
  // print("Last Value is ${fruits.last}");
  // print("Is fruits empty? ${fruits.isEmpty}");
  // print("Is fruits not empty? ${fruits.isNotEmpty}");
  // print("The length of fruits is ${fruits.length}");

  Map<String, String> countryCapital = {
    'USA': 'Washington, D.C.',
    'India': 'New Delhi',
    'China': 'Beijing'
  };
  // print(countryCapital);

  Map<String, double> expenses = {
    'sun': 3000.0,
    'mon': 3000.0,
    'tue': 3234.0,
  };
  // print(countryCapital["USA"]);

  // print("All keys of Map: ${expenses.keys}");
  // print("All values of Map: ${expenses.values}");
  // print("Is Map empty: ${expenses.isEmpty}");
  // print("Is Map not empty: ${expenses.isNotEmpty}");
  // print("Length of map is: ${expenses.length}");

  countryCapital['Japan'] = 'Tokio';
  
  print(countryCapital);

  // Without List
  print("All keys of Map: ${expenses.keys}");
  print("All values of Map: ${expenses.values}");

  // With List
  print("All keys of Map with List: ${expenses.keys.toList()}");
  print("All values of Map with List: ${expenses.values.toList()}");

  List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  List<String> startWithS =
      days.where((element) => element.startsWith("S")).toList();
}





// Exercise: Create a map with name, phone keys and store some values to it. Use where to find all keys that have length 4.




