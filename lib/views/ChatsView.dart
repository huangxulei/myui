import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myui/components/Chat.dart';
import 'package:myui/components/ChatHistoryList.dart';
import 'package:myui/components/chatHistoryController.dart';

class ChatsView extends StatelessWidget {
  var inputValue = ''.obs;
  Color textColor = Color.fromARGB(255, 101, 99, 99);
  Color bgDarkColor = Color.fromARGB(255, 218, 216, 216);
  Color bgColor = Color.fromARGB(255, 239, 237, 237);
  Color topBgColor = Color.fromARGB(255, 248, 246, 246);

  ChatHistoryController chatHistoryController =
      Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: const Border(
                right: BorderSide(
              width: 1,
              color: Colors.black12,
            )),
            color: bgColor,
          ),
          width: 250,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: bgDarkColor,
                ))),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: bgDarkColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            maxLines: 1,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // 上下边距
                              isDense: true,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: '搜索',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.search, color: textColor),
                              // 添加图标
                              prefixIconConstraints:
                                  const BoxConstraints.tightFor(
                                      width: 30, height: 20), // 设置图标大小
                            ),
                            style: TextStyle(
                                fontSize: 12, // 设置文字字号
                                fontFamily:
                                    'Roboto;Arial;Helvetica;Georgia;微软雅黑',
                                color: textColor),
                            onChanged: (value) {
                              inputValue.value = value;
                            },
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        // 原型按钮
                        IconButton(
                          onPressed: () {
                            chatHistoryController.addChat();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(bgDarkColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5))), // 设置背景颜色与输入框的文字颜色一致
                          ),
                          icon: const Icon(Icons.add),
                          color: textColor,
                          hoverColor: Color.fromARGB(255, 164, 162, 166),
                          padding: const EdgeInsets.all(0),
                          iconSize: 20,
                          constraints: const BoxConstraints.tightFor(
                              width: 30, height: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: ChatHistoryList()),
            ],
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.transparent,
          child: Obx(() => chatHistoryController.selectedChatId.value.isEmpty
              ? Container(
                  color: Colors.white,
                  child: const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat, size: 100, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        "Welecome GPTCraft",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )))
              : Chat(id: chatHistoryController.selectedChatId.value)),
        ))
      ],
    );
  }
}
