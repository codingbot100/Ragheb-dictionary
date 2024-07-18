import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class splashclass extends GetxController {
  RxBool checkPage = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkIfWelcomeScreenShown();
  }

  void checkIfWelcomeScreenShown() async {
    var box = Hive.box('mybox');
    bool? hasShownWelcomeScreen = box.get('hasShownWelcomeScreen');
    if (hasShownWelcomeScreen == null || !hasShownWelcomeScreen) {
      checkPage.value = false;
    } else {
      checkPage.value = true;
    }
  }

  void setWelcomeScreenShown() {
    var box = Hive.box('mybox');
    box.put('hasShownWelcomeScreen', true);
  }
}