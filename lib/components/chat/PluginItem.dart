import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myui/components/chat/ChatSettingController.dart';
import 'package:myui/components/chatHistoryController.dart';
import 'package:myui/gpt/plugins/GPTPluginInterface.dart';
import 'package:myui/utils/Util.dart';

class PluginItem extends StatelessWidget {
  final GPTPluginInterface plugin;

  PluginItem({required this.plugin});

  final ChatSettingController controller = Get.put(ChatSettingController());
  final ChatHistoryController chatHistoryController =
      Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: plugin.icon,
          ),
          const SizedBox(width: 10),
          Text(plugin.name),
          Expanded(child: Container()),
          // 开关按钮
          Obx(() => Switch(
                value:
                    controller.currentChat.value.plugins.contains(plugin.name),
                onChanged: (value) {
                  if (value) {
                    controller.currentChat.update((val) {
                      val!.plugins.add(plugin.name);
                      Util.writeFile(
                          'chats/${controller.currentChat.value.id}.json',
                          jsonEncode(controller.currentChat.value));
                    });
                  } else {
                    controller.currentChat.update((val) {
                      val!.plugins.remove(plugin.name);
                      Util.writeFile(
                          'chats/${controller.currentChat.value.id}.json',
                          jsonEncode(controller.currentChat.value));
                    });
                  }
                },
              )),
        ],
      ),
      subtitle: Text(plugin.description),
    );
  }
}
