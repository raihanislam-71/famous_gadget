import 'package:get/get.dart';

class ReviewController extends GetxController {
  bool isExpanded = false;

  void toggleExpand() {
    isExpanded = !isExpanded;
    update();
  }
}