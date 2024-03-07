import 'package:get/get.dart';

class HomeController extends GetxController{
  RxString topNewsTitle = "Top News".obs;
  RxInt tabIndex = 0.obs;
  RxBool isLoading = true.obs;
}