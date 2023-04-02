void main() {
  String name = "john";
  print(name.capitalize());
  int num = 10;
  print(num.add(5));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension IntExtension on int {
  int add(int num) {
    return this + num;
  }
}
