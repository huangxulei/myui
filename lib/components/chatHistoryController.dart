import 'dart:convert';

import 'package:get/get.dart';
import 'package:myui/entity/ChatSimpleItem.dart';
import 'package:myui/utils/Util.dart';

class ChatHistoryController extends GetxController {
  var selectedChatId = ''.obs;

  RxList<ChatSimpleItem> items = RxList<ChatSimpleItem>([]);

  void addChat() {
    items.add(ChatSimpleItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: "new chat",
        avatar: "",
        lastMessage: " ",
        lastMessageTime: ""));
    Util.writeFile('histroy.json', jsonEncode(items));
    update();
  }

  void removeChat(ChatSimpleItem chat) {
    items.remove(chat);
    Util.writeFile('history.json', jsonEncode(items));
    update();
  }

  //启动运行
  @override
  void onReady() {
    //读取json文件
    Util.readFile('history.json').then((value) {
      //json string文件
      if (value.isEmpty) {
        value = jsonEncode([
          ChatSimpleItem(
              id: '0',
              avatar: '',
              name: 'New Chat',
              lastMessage: '',
              lastMessageTime: ''),
        ]);
        Util.writeFile('history.json', value);
        selectedChatId.value = '0';
      }
      jsonDecode(value)
          .map<ChatSimpleItem>((item) => ChatSimpleItem.fromJson(item))
          .toList()
          .forEach((element) {
        items.add(element);
      });
      update();
    });
    super.onReady();
  }

  void selectChat(String id) {
    selectedChatId.value = id;
    update();
  }

  void updateChatName(String id, String name) {
    items.firstWhere((element) => element.id == id).name = name;
    items.refresh();
    Util.writeFile('history.json', jsonEncode(items));
    update();
  }

  void updateChatAvatar(String id, String value) {
    items.firstWhere((element) => element.id == id).avatar = value;
    items.refresh();
    Util.writeFile('history.json', jsonEncode(items));
    update();
  }
}
