import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  VideoPage({super.key});

  var videoPath = ''.obs;
  var controller = VideoPlayerController.file(File(''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Page')),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: Size.infinite.width,
                  height: 480,
                  child: videoPath.value == ''
                      ? Image.asset('assets/images/no_video.jpg')
                      : VideoPlayer(controller),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final fileVideo = await ImagePicker()
                          .pickVideo(source: ImageSource.camera);
                      if (fileVideo == null) {
                        videoPath('');
                      } else {
                        videoPath(fileVideo.path);
                        controller =
                            VideoPlayerController.file(File(fileVideo.path));
                        await controller.initialize();
                        await controller.setLooping(true);
                        await controller.play();
                      }
                    },
                    child: const Text('Record Video'))
              ],
            ),
          )),
    );
  }
}
