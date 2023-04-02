class IntData {
  int data;
  IntData(this.data);
  void display() {
    print("IntData : ${this.data}");
  }
}

// Creating a class for double
class DoubleData {
  double data;
  DoubleData(this.data);
  void display() {
    print("DoubleData : ${this.data}");
  }
}

class Data<T extends num> {
  T data;
  Data(this.data);
  void display() {
    print("Data : ${this.data}");
  }
}

void main() {
  // Create an object of IntData class
  Data intData = Data(10);
  List list = [1, 2, 3, 4, 5];
  Data doubleData = Data(10.5);
  // Print the data
  intData.display();
  doubleData.display();
}





// Final exiricse: Create a simple quiz application using oop that allows users to play and view their score