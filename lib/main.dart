import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myui/component/MainMenu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  // 判断是否是Linux 设置主题样式
  if (!Platform.isLinux) {
    // 判断是Windows10 1803以上版本
    if (Platform.isWindows) {
      await Window.setEffect(
        // effect: WindowEffect.acrylic,
        effect: WindowEffect.solid,
        color: Colors.transparent,
      );

      if (Platform.operatingSystemVersion.contains('(')) {
        print(Platform
            .operatingSystemVersion); //"Windows 10 Pro" 10.0 (Build 19045)
        var version = Platform.operatingSystemVersion
            .split('(')[1]
            .split(')')[0]
            .toLowerCase()
            .replaceAll('build', '')
            .trim();
        if (int.parse(version) > 19045) {
          await Window.setEffect(
            effect: WindowEffect.acrylic,
            color: Colors.transparent,
          );
        }
      }
    } else {
      await Window.setEffect(
        effect: WindowEffect.acrylic,
        color: Colors.transparent,
      );
    }
  }
  //设置界面大小
  appWindow.size = const Size(1000, 650);
  runApp(const MyApp());
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(900, 600);
    win.minSize = initialSize;
    win.size = appWindow.size;
    win.alignment = Alignment.center;
    win.title = "MyUi";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(children: [
              LeftSide(
                child: MainMenu(),
              ),
              RightSide()
            ])));
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 65,
        child: Container(
            // 渐变颜色
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(170, 53, 36, 77),
                  Color.fromARGB(170, 53, 36, 77)
                ], // 这里设置您想要的颜色
              ),
            ),
            child: Column(
              children: [
                // WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: child),
              ],
            )));
  }
}

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
        color: Colors.transparent,
      )
    ]));
  }
}
