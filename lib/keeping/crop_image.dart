import 'dart:io';

import 'package:bookkeeping/addons/image_picker.dart';
import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/bean/crop_enhance_bean.dart';
import 'package:bookkeeping/bean/receipt_classify.dart';
import 'package:bookkeeping/bean/shop_ticket_bean.dart';
import 'package:bookkeeping/bean/text_sort_bean.dart';
import 'package:bookkeeping/bean/train_ticket_bean.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropImagePage extends StatefulWidget {
  const CropImagePage({super.key});

  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  double zoomScale = 0.5;
  String? imagePath = Get.arguments['image'];
  File? sourceFile;
  String? base64;
  Image? image;
  bool isLoading = false;

  // 图片参数
  int enhanceMode = -1;
  int cropImage = 1;
  int correctDirection = 0;

  @override
  void initState() {
    super.initState();
    if (imagePath != null) {
      sourceFile = File(Get.arguments['image']);
      image = Image.file(sourceFile!, fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(15, 55, 15, 15),
              children: [
                if (image == null) _getCanvas(),
                if (image != null)
                  SizedBox(height: 500, child: Center(child: image)),
                const SizedBox(height: 15),
                // _getSlider(),
                const SizedBox(height: 10),
                // 操作按钮
                if (image != null)
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        _getIcon(
                          name: '增强',
                          iconPath: AppAssets.enhance,
                          value: 1,
                        ),
                        _getIcon(
                          name: '锐化',
                          iconPath: AppAssets.sharpening,
                          value: 2,
                        ),
                        _getIcon(
                          name: '黑白',
                          iconPath: AppAssets.blackWhite,
                          value: 3,
                        ),
                        _getIcon(
                          name: '灰度',
                          iconPath: AppAssets.grayLevel,
                          value: 4,
                        ),
                        _getIcon(
                          name: '阴影',
                          iconPath: AppAssets.shadow,
                          value: 5,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 55),
              ],
            ),
          ),
          // 确认或取消按钮
          Positioned(
            bottom: 0,
            child: Container(
              color: AppTheme.themeColor,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () async {
                          isLoading = true;
                          setState(() {});
                          // 先票据分类
                          ReceiptClassifyBean bean1 =
                              await AppNet.receiptClassify(sourceFile!);
                          print('票据类型：' + bean1.receiptType!);
                          // 如果是火车票
                          if (bean1.receiptType == 'train_ticket') {
                            TrainTicketBean bean2 =
                                await AppNet.trainTicketOCR(sourceFile!);
                            isLoading = false;
                            setState(() {});
                            Get.toNamed(
                              AppRouter.addBill,
                              arguments: {
                                'bean': bean2,
                                'image': image,
                                'add_bill': true,
                                'money': bean2.money,
                                'item': bean2.item,
                                'time': bean2.time,
                                'from': bean2.shop,
                                'receipt_type': '火车票',
                                'sub_type': bean2.subType,
                                'image_file': sourceFile,
                              },
                            );
                          }
                          // 为商铺小票
                          else {
                            ShopTicketBean bean2;
                            bean2 = await AppNet.shopTicketOCR(sourceFile!);
                            // 调用文本分类判断具体消费类型
                            if (bean2.item != null) {
                              TextSortBean sortBean =
                                  await AppNet.textSort(text: bean2.item!);
                              bean2.subType = sortBean.subType;
                            }
                            isLoading = false;
                            setState(() {});
                            Get.toNamed(
                              AppRouter.addBill,
                              arguments: {
                                'bean': bean2,
                                'image': image,
                                'add_bill': true,
                                'money': bean2.money,
                                'item': bean2.item,
                                'time': bean2.time,
                                'from': bean2.shop,
                                'receipt_type':
                                    bean1.receiptType == 'shop_receipt'
                                        ? '小票'
                                        : '其他',
                                'sub_type': bean2.subType,
                                'image_file': sourceFile,
                              },
                            );
                          }
                          // 默认为其他
                          // else {
                          //   isLoading = false;
                          //   setState(() {});
                          //   Get.toNamed(AppRouter.addBill, arguments: {
                          //     'receipt_type': '其他',
                          //     'image_file': sourceFile,
                          //   });
                          // }
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // 环形加载条
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppTheme.orangeTheme,
                strokeWidth: 6,
              ),
            ),
        ],
      ),
    );
  }

  /// 画布
  Widget _getCanvas() {
    return GestureDetector(
      onTap: () async {
        sourceFile = await pickImage();
        if (sourceFile != null) {
          setState(() {
            image =
                Image.file(sourceFile!, fit: BoxFit.contain, scale: zoomScale);
          });
        }
      },
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '账单\n图片',
            style: TextStyle(fontSize: 30, color: AppTheme.lightGrey),
          ),
        ),
      ),
    );
  }

  /// 滑动条
  // ignore: unused_element
  Widget _getSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 15,
        inactiveTrackColor: Colors.white,
        activeTrackColor: Colors.white,
        thumbColor: AppTheme.lightGreen,
        overlayColor: AppTheme.orangeTheme,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: Slider(
        value: zoomScale,
        onChanged: (value) {
          setState(() {
            zoomScale = value;
          });
        },
      ),
    );
  }

  /// 操作按钮
  Widget _getIcon({
    required String name,
    required String iconPath,
    required int value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Ink(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: enhanceMode == value ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (isLoading) return;
            if (enhanceMode == value) {
              enhanceMode = -1;
              image = Image.file(sourceFile!);
              base64 = null;
              setState(() {});
            } else {
              enhanceMode = value;
              _cropImage();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Column(
              children: [
                Image.asset(iconPath, width: 30, height: 30),
                const SizedBox(height: 5),
                Text(
                  name,
                  style: const TextStyle(
                    color: AppTheme.themeColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cropImage() async {
    isLoading = true;
    setState(() {});
    CropEnhanceBean bean = await AppNet.cropEnhance(
      sourceFile!,
      enhanceMode: enhanceMode,
    );
    image = bean.image;
    base64 = bean.base64;
    isLoading = false;
    setState(() {});
  }
}
