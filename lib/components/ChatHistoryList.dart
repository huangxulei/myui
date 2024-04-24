import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myui/components/ChatListItem.dart';
import 'package:myui/components/chatHistoryController.dart';

class ChatHistoryList extends StatelessWidget {
  ChatHistoryController controller = Get.put(ChatHistoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          return ChatListItem(item: controller.items[index]);
        },
      );
    });
  }
}
