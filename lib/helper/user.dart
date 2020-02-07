class User {
  static String name;
  static String email;
  static String gender;
  static String number;
  static String bio;
  static String expectation;

  void clear() {
    name = '';
    email = '';
    gender = '';
    number = '';
    bio = '';
    expectation = '';
  }

  Future<void> fetchName() async {}
}
