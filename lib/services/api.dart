import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

String basicAuth = 'Basic ${base64Encode(
  utf8.encode('admin:12345'),
)}';
Map<String, String> myheaders = {
  "Authorization": basicAuth,
};

class Api {
  postRespones(
    String url,
    Map data,
  ) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postResponesWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiParFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multiParFile);
    request.headers.addAll(myheaders);
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error${response.statusCode}");
    }
  }
}
