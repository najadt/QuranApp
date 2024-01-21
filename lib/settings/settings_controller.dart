import 'package:get/get.dart';
import 'package:quran/constants_variables.dart';
import 'package:quran/theme/theme.dart';

class SettingsController extends GetxController {
  RxBool themeMode = theme.obs;

  void changeTheme(i) {
    Get.changeTheme(!i ? lightMode : darkmode);
    print(Get.isDarkMode);
  }
}
