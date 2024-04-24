import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class Util {
  static String getMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  static Future<String> copyImageToAppDir() async {
    final directory = await getApplicationCacheDirectory();

    // 假设您的图片文件位于assets文件夹中
    ByteData data = await rootBundle.load('assets/chatgpt.png');
    List<int> bytes = data.buffer.asUint8List();
    File imageFile = File('${directory.path}/default-avatar.png');
    await imageFile.writeAsBytes(bytes);

    return imageFile.path;
  }

  static Future<String> saveImageFormUrl(String url) async {
    final directory = await getApplicationCacheDirectory();
    File imageFile = File('${directory.path}/cache/${getMd5(url)}');
    if (imageFile.existsSync() && imageFile.lengthSync() != 0) {
      return imageFile.path;
    } else {
      imageFile.createSync(recursive: true);
    }
    Uri uri = Uri.parse(url);
    var request = http.Request('GET', uri);
    http.Client client = http.Client();
    return client.send(request).then((response) {
      return response.stream.toBytes().then((value) {
        return imageFile.writeAsBytes(value).then((value) {
          return imageFile.path;
        });
      });
    });
  }

  static Future<String> pickAndSaveImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationCacheDirectory();
      final File imageFile =
          File('${directory.path}/select-images/${pickedFile.name}');
      if (imageFile.existsSync() == false) {
        imageFile.createSync(recursive: true);
      }
      await imageFile.writeAsBytes(await pickedFile.readAsBytes());
      return imageFile.path;
    }
    return '';
  }

  static void writeFile(String filename, String content) async {
    final directory = await getApplicationCacheDirectory();
    final File imageFile = File('${directory.path}/files/$filename');
    if (imageFile.existsSync() == false) {
      imageFile.createSync(recursive: true);
    }
    await imageFile.writeAsString(content);
  }

  static Future<String> readFile(String filename) async {
    final directory = await getApplicationCacheDirectory();
    final File file = File('${directory.path}/files/$filename');
    if (file.existsSync() == false) {
      return '';
    }
    return file.readAsString();
  }

  static void postStream(String url, Map<String, String> header,
      Map<String, dynamic> body, Function callback) async {
    Uri uri = Uri.parse(url);
    var request = http.Request('POST', uri);

    request.body = jsonEncode(body);

    Map<String, String> headers = {"Content-type": "application/json"};
    headers.addAll(header);
    http.Client client = http.Client();
    client.head(uri, headers: headers);
    client.send(request).then((response) {
      response.stream.listen((List<int> data) {
        callback(data);
        print(data);
      });
    });
  }

  static Future<String> post(
      String url, Map<String, String> header, Map<String, dynamic> body) async {
    Uri uri = Uri.parse(url);
    var request = http.Request('POST', uri);

    request.body = jsonEncode(body);

    Map<String, String> headers = {
      // "Content-type": "application/json"
    };
    headers.addAll(header);
    request.headers.addAll(headers);
    http.Client client = http.Client();
    return client.send(request).then((response) {
      return response.stream.bytesToString();
    });
  }
}

typedef GPTCallbackFunction = void Function(String result, bool finish);
