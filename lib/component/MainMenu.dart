import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myui/component/Avatar.dart';
import 'package:myui/controller/SettingController.dart';
import 'package:myui/utils/MyIcons.dart';

class MainMenu extends StatelessWidget {
  final MainMenuController controller = Get.put(MainMenuController());

  Color textColor = const Color.fromARGB(150, 255, 255, 255);
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: WindowTitleBarBox(child: MoveWindow()),
        ),
        //图标
        Obx(() => Avatar(
              filePath: settingController.setting.value.profileSetting.avatar,
              size: 40,
            )),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: controller.active.value == 'chats'
                      ? Color.fromARGB(255, 119, 80, 169)
                      : Colors.transparent,
                  width: 6, // 设置边框宽度
                ),
              ),
              color: controller.active.value == 'chats'
                  ? Color.fromARGB(100, 64, 46, 88)
                  : Colors.transparent,
            ),
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                controller.open('chats');
              },
              child: Icon(
                MyIcons.chat,
                color: controller.active.value == 'chats'
                    ? Colors.white
                    : textColor,
              ),
            ),
          ),
        ),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: controller.active.value == 'github'
                      ? Color.fromARGB(255, 119, 80, 169)
                      : Colors.transparent,
                  width: 6, // 设置边框宽度
                ),
              ),
              color: controller.active.value == 'github'
                  ? Color.fromARGB(100, 64, 46, 88)
                  : Colors.transparent,
            ),
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                controller.open('github');
              },
              child: Icon(
                MyIcons.github,
                color: controller.active.value == 'github'
                    ? Colors.white
                    : textColor,
              ),
            ),
          ),
        ),
        Expanded(child: Container()),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: controller.active.value == 'setting'
                      ? Color.fromARGB(255, 119, 80, 169)
                      : Colors.transparent,
                  width: 6, // 设置边框宽度
                ),
              ),
              color: controller.active.value == 'setting'
                  ? Color.fromARGB(100, 64, 46, 88)
                  : Colors.transparent,
            ),
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                controller.open('setting');
              },
              child: Icon(
                Icons.settings,
                color: controller.active.value == 'setting'
                    ? Colors.white
                    : textColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class MainMenuController extends GetxController {
  var active = 'chats'.obs;
  void open(String menu) => {active.value = menu};
}
