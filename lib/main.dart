import 'dart:io';
import 'package:camera_flutter/video_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  var imagePath = ''.obs;
  Future<void> openCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      imagePath('');
    } else {
      imagePath(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Camera',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Camera'),
          ),
          body: Obx(
            () => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: Size.infinite.width,
                    height: 480,
                    child: imagePath.value == ''
                        ? Image.asset('assets/images/no_image.jpg')
                        : Image.file(File(imagePath.value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await openCamera();
                          },
                          child: const Text('Take Picture')),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => VideoPage());
                          },
                          child: const Text('Take Video'))
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
