import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int _selectedIndex = 0;
  int? _previousSelectedIndex;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void enterCartRoute() {
    _previousSelectedIndex = _selectedIndex;
    changeIndex(2);
  }

  void leaveCartRoute() {
    final previousIndex = _previousSelectedIndex;
    _previousSelectedIndex = null;
    if (previousIndex != null) changeIndex(previousIndex);
  }

  void backToHome() {
    changeIndex(0);
  }
}
