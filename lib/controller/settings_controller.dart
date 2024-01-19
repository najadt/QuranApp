import 'package:get/get.dart';
import 'package:quran/constants_variables.dart';
import 'package:quran/theme/theme.dart';

class SettingsController extends GetxController {
  RxBool themeMode = theme.obs;

  void changeTheme() {
    Get.changeTheme(Get.isDarkMode ? lightMode : darkmode);
    //print(themeMode);
  }
}
