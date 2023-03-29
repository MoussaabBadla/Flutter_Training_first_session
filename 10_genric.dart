class IntData {
  int data;
  IntData(this.data);
}

// Creating a class for double
class DoubleData {
  double data;
  DoubleData(this.data);
}

// class Data<T> {
//   T data;
//   Data(this.data);
// }

void main() {
  // Create an object of IntData class
  IntData intData = IntData(10);
  DoubleData doubleData = DoubleData(10.5);
  // Print the data
  print("IntData: ${intData.data}");
  print("DoubleData: ${doubleData.data}");
}





// Final exiricse: Create a simple quiz application using oop that allows users to play and view their score