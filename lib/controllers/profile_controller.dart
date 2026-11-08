import 'package:get/get.dart';

class ProfileController extends GetxController {
  String firstName = 'Arif';
  String lastName = 'Rahman';
  String email = 'arif@gmail.com';
  String phone = '+880 1712 345678';
  String city = 'Dhaka';

  String get fullName => '$firstName $lastName'.trim();
  String get initials => [
    if (firstName.isNotEmpty) firstName[0],
    if (lastName.isNotEmpty) lastName[0],
  ].join().toUpperCase();

  void updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phone = phone;
    update();
  }
}
