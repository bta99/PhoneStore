import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  PickedFile? file;
  String imagePath = "";
  XFile? tmpfile;
  String base64image = "";

  final picker = ImagePicker();
  Future chooseImage() async {
    // ignore: deprecated_member_use
    file = (await picker.getImage(source: ImageSource.gallery));
    setState(() {
      imagePath = file!.path;
    });
  }

  Future<void> uploadFile(File image) async {
    final bytes = image.readAsBytesSync();
    print(base64Encode(bytes));
    String endpoint = "http://192.168.1.6:8000/api/upload";
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({'cc': base64Encode(bytes)}));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['check'];
      } catch (e) {
        print('faild 1');
      }
    } else {
      print('faild 2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload file'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      chooseImage();
                    },
                    child: const Text('select Image')),
              ),
              imagePath != ""
                  ? Container(
                      width: 150,
                      height: 105,
                      child: Image.file(File(imagePath)),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      ),
                    ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () async {
                      print(File(file!.path));
                      uploadFile(File(file!.path));
                    },
                    child: const Text('Upload file')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
