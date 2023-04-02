// import '13_null_safety.dart';

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
// class CanFlyclass {

// }
// class CanWalkclass{

// }

// class Bird with CanFly, CanWalk {}

// class Human with CanWalk {

// }

// void main() {
//   Bird bird = Bird();
//   bird.fly();
//   bird.walk();

//   var human = Human();
//   human.walk();
// }

mixin CanWalk {
  void walk() {
    print('I can walk');
  }
}

class Bird with CanWalk {
  void fly() {}
}

mixin CanFly on Bird {
  @override
  void fly() {
    print('I can fly');
  }
}

class Human with CanWalk {}

class MiniBird extends Bird with CanFly {}

void main() {
  var bird = MiniBird();
  bird.walk();
  bird.fly();

  var human = Human();
  human.walk();
}
