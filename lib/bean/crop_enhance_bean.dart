import 'dart:convert';

import 'package:flutter/material.dart';

class CropEnhanceBean {
  int? status;
  int? originWidth;
  int? originHeight;
  int? croppedWidth;
  int? croppedHeight;
  Image? image;
  String? message;
  String? base64;

  CropEnhanceBean.fromMap(Map map) {
    Map? result;
    Map? imageList;

    status = map['code'];
    message = map['message'];
    result = map['result'];
    imageList = result?['image_list'][0];
    originHeight = result?['origin_height'];
    originWidth = result?['origin_width'];
    croppedWidth = imageList?['cropped_width'];
    croppedHeight = imageList?['cropped_height'];
    // image = Image.memory(base64Decode(imageList?['image']));
    String? base = imageList?['image'];
    if (base != null) {
      base64 = base;
      image = Image.memory(base64Decode(base64!), fit: BoxFit.contain);
    }
  }

  @override
  String toString() => '';
}
