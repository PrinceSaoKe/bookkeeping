import 'dart:io';

import 'package:image_picker/image_picker.dart';

/// 从相册中选择一张图片
Future<File?> pickImage({int quality = 10}) async {
  XFile? image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: quality,
  );
  if (image == null) return null;
  return File(image.path);
}

/// 从相册中选择多张图片
Future<List<File>> pickImages({int quality = 10}) async {
  List<XFile> xList = await ImagePicker().pickMultiImage(imageQuality: quality);
  List<File> imageList = [];
  for (var element in xList) {
    imageList.add(File(element.path));
  }
  return imageList;
}

/// 从相册中选择一个视频
Future<File?> pickVideo() async {
  XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (video == null) return null;
  return File(video.path);
}

/// 拍摄照片
Future<File?> takePhoto({int quality = 10}) async {
  XFile? image = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: quality,
  );
  if (image == null) return null;
  return File(image.path);
}

/// 拍摄视频
Future<File?> takeVideo() async {
  XFile? video = await ImagePicker().pickVideo(source: ImageSource.camera);
  if (video == null) return null;
  return File(video.path);
}
