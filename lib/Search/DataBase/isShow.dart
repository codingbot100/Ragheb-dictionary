
import 'package:get/get.dart';

class show  extends GetxController{
  var isShow = true.obs;
  @override
  void onInit() {
    super.onInit();
    
  }
  void toggle(){
    isShow.value = !isShow.value;
  }
}
