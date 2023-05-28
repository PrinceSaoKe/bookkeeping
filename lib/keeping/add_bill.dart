import 'dart:io';

import 'package:bookkeeping/addons/flutter_sound.dart';
import 'package:bookkeeping/addons/image_picker.dart';
import 'package:bookkeeping/app_assets.dart';
import 'package:bookkeeping/app_net.dart';
import 'package:bookkeeping/app_router.dart';
import 'package:bookkeeping/app_theme.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/speech_recognition_bean.dart';
import 'package:bookkeeping/bean/universal_bean.dart';
import 'package:bookkeeping/customed_widgets/alert_dialog.dart';
import 'package:bookkeeping/customed_widgets/customed_button.dart';
import 'package:bookkeeping/customed_widgets/over_scroll_behavior.dart';
import 'package:bookkeeping/customed_widgets/simple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({super.key});

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  PageController pageController = PageController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  double? money;
  String currCountry = '人民币';
  String? receiptType;
  String type = 'expend';
  String? subType;
  String? item;
  String? from;
  Image? image;
  File? imageFile;
  double pageIndex = 0;
  String? remark;
  AppSoundRecorder soundRecorder = AppSoundRecorder();
  late TextEditingController selectedInput;

  @override
  void initState() {
    super.initState();
    selectedInput = itemController;

    if (Get.arguments != null) {
      if (Get.arguments['money'] != null) money = Get.arguments['money'];
      if (Get.arguments['item'] != null) item = Get.arguments['item'];
      if (Get.arguments['time'] != null) {
        DateTime dateTime = Get.arguments['time'];
        date = dateTime;
        time = TimeOfDay.fromDateTime(dateTime);
      }
      if (Get.arguments['from'] != null) from = Get.arguments['from'];
      if (Get.arguments['receipt_type'] != null) {
        receiptType = Get.arguments['receipt_type'];
      }
      if (Get.arguments['sub_type'] != null) {
        subType = Get.arguments['sub_type'];
      }
      if (Get.arguments['remark'] != null) remark = Get.arguments['remark'];
      if (Get.arguments['image_file'] != null) {
        imageFile = Get.arguments['image_file'];
        if (imageFile != null) image = Image.file(imageFile!);
      }
      if (Get.arguments['image'] != null) image = Get.arguments['image'];
    }
    pageController.addListener(() {
      pageIndex = pageController.page ?? 0;
      setState(() {});
    });
    itemController.addListener(() {
      item = itemController.text;
      selectedInput = itemController;
    });
    remarkController.addListener(() {
      remark = remarkController.text;
      selectedInput = remarkController;
    });
    fromController.addListener(() {
      from = fromController.text;
      selectedInput = fromController;
    });
    moneyController.addListener(() {
      double? temp = double.tryParse(moneyController.text);
      temp ??= double.tryParse(moneyController.text.replaceAll('。', ''));
      money = temp;
      selectedInput = moneyController;
    });

    soundRecorder.openSoundRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppTheme.darkGold,
        centerTitle: true,
        title: SizedBox(
          width: 180,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {});
                },
                child: Text(
                  '支出',
                  style: pageIndex < 0.5
                      ? const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        )
                      : null,
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {});
                },
                child: Text(
                  '收入',
                  style: (pageIndex >= 0.5 && pageIndex < 1.5)
                      ? const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        )
                      : null,
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {});
                },
                child: pageIndex >= 1.5
                    ? const Text(
                        '图片',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    : const Text('图片'),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            child: const Icon(Icons.check),
            onTap: () async {
              if (money == null) {
                alertDialog(context, title: '错误', text: '请输入账单金额！');
                return;
              } else if (item == null || item == '') {
                alertDialog(context, title: '错误', text: '请输入商品名称！');
                return;
              } else if (date == null) {
                alertDialog(context, title: '错误', text: '请选择消费日期！');
                return;
              } else if (time == null) {
                alertDialog(context, title: '错误', text: '请选择消费时间！');
                return;
              } else if (from == '') {
                alertDialog(context, title: '错误', text: '请输入消费商家或交易方！');
                return;
              } else if (subType == null) {
                alertDialog(context, title: '错误', text: '请选择消费类型！');
                return;
              } else if (receiptType == null) {
                alertDialog(context, title: '错误！', text: '请选择票据类型！');
                return;
              }
              if (subType == '其他 ') subType = '其他';
              UniversalBean bean = await AppNet.newBill(
                type: type,
                subtype: subType!,
                receiptType: receiptType!,
                time: DateTime.parse(
                  '${AppTools.toY0M0D(date!)} ${AppTools.to0Hour0MinTime(time!)}:00',
                ),
                money: money!,
                from: from!,
                item: item!,
                remark: remark,
                image: imageFile,
              );
              await alertDialog(context,
                  title: bean.message ?? '未知错误',
                  text: bean.status == 200 ? '账单已成功添加！' : '账单添加失败！');
              Get.until((route) => route.settings.name == AppRouter.root);
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      bottomSheet: _getCustomedKeyboard(),
      body: PageView(
        controller: pageController,
        children: [_getExpendPage(), _getIncomePage(), _imagePage()],
      ),
    );
  }

  Widget _getCustomedKeyboard() {
    return Container(
      height: 380,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      color: AppTheme.themeColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getMoney(),
          _getItemName(),
          Row(
            children: [
              _getPickerOption(context: context, text: '日期'),
              const SizedBox(width: 10),
              _getTime(context: context, text: '时间'),
            ],
          ),
          Row(
            children: [
              Expanded(child: _getFrom()),
              const SizedBox(width: 10),
              _getReceipt(),
            ],
          ),
          _getRemark(),
        ],
      ),
    );
  }

  /// 商品名称输入框
  _getItemName() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            const Text(
              '账单内容：',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Expanded(
              child: TextField(
                controller: itemController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: item ?? '',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                onChanged: (text) {
                  item = text;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 商家/交易方
  _getFrom() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            const Text(
              '商家：',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Expanded(
              child: TextField(
                controller: fromController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: from ?? '',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                onChanged: (text) {
                  from = text;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 备注
  _getRemark() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      '备注：',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 3,
                      controller: remarkController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: remark ?? '',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      onChanged: (text) {
                        remark = text;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: AppTheme.orangeTheme,
                child: const Icon(Icons.mic),
                onPressed: () async {
                  print('调用录音');
                  soundRecorder.record();

                  await AppTools.showPopup(
                    context,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mic, color: Colors.white, size: 50),
                        Text(
                          '请说话',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                  );
                  soundRecorder.stopRecorder();
                  SpeechRecognitionBean bean = await AppNet.speechRecognition(
                    filePath: soundRecorder.audioPath,
                  );
                  selectedInput.text = bean.result;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 金额输入框
  _getMoney() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      // width: 300,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          const Text(
            '金额：',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Expanded(
            child: TextField(
              controller: moneyController,
              cursorColor: Colors.white,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: money?.toStringAsFixed(2),
                hintStyle: const TextStyle(color: Colors.white),
              ),
              onChanged: (text) {
                money = double.tryParse(text);
                setState(() {});
              },
            ),
          ),
          Text(
            currCountry == '人民币' ? '元' : currCountry,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(width: 10),
          _getExchangeRate(),
        ],
      ),
    );
  }

  /// 汇率转换按钮
  Widget _getExchangeRate() {
    return ElevatedButton.icon(
      onPressed: () {
        if (money == null) {
          alertDialog(context, title: '错误', text: '账单金额格式错误！');
          return;
        }
        Get.toNamed(
          AppRouter.exchangeRate,
          arguments: {'money': money, 'country': currCountry},
        )?.then((result) {
          currCountry = result['country'];
          moneyController.clear();
          money = result['money'];
          setState(() {});
        });
      },
      icon: const Icon(Icons.currency_exchange),
      label: const Text('汇率转换'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.orangeTheme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  /// 日期选择框
  Widget _getPickerOption(
      {required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 50),
          side: const BorderSide(color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        child: Text(
          date == null ? text : AppTools.toY0M0D(date!),
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          date = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime(2050, 1, 1),
          );
          setState(() {});
        },
      ),
    );
  }

  /// 时间选择框
  Widget _getTime({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 50),
          side: const BorderSide(color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        child: Text(
          time == null ? text : AppTools.to0Hour0MinTime(time!),
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          time = await showTimePicker(
            context: context,
            initialTime: time ?? TimeOfDay.now(),
          );
          setState(() {});
        },
      ),
    );
  }

  /// 票据类型
  Widget _getReceipt() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.arrow_drop_down),
        label: Text(receiptType ?? '票据类型'),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(120, 50),
          backgroundColor: AppTheme.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: () async {
          String? result = await simpleDialog(context, title: '请选择票据类型');
          if (result != null) receiptType = result;
          setState(() {});
        },
      ),
    );
  }

  /// 废弃
  _getRaw() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.only(left: 7, right: 7),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: remarkController,
                maxLines: 4,
                minLines: 4,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '点击输入备注...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 91,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '金额：',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextField(
                  controller: moneyController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    // hintText: '点击输入金额...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  _getExpendPage() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: GridView.extent(
        maxCrossAxisExtent: 100,
        children: [
          SubtypeOptionButton(
            imagePath: AppAssets.canying,
            label: '餐饮',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '餐饮';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.yule,
            label: '娱乐',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '娱乐';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.jujia,
            label: '居家',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '居家';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.wenhuajiaoyu,
            label: '文化',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '文化';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.jiaotong,
            label: '交通',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '交通';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.bangong,
            label: '办公',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '办公';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.yundong,
            label: '运动',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '运动';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.fuzhuang,
            label: '服装',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '服装';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.yiliao,
            label: '医疗',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '医疗';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.gouwu,
            label: '购物',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '购物';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.chongwu,
            label: '宠物',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '宠物';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.qita,
            label: '其他',
            std: subType,
            onPress: () {
              type = 'expend';
              subType = '其他';
              setState(() {});
              print(type);
            },
          ),
        ],
      ),
    );
  }

  _getIncomePage() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: GridView.extent(
        maxCrossAxisExtent: 100,
        children: [
          SubtypeOptionButton(
            imagePath: AppAssets.gongzi,
            label: '工资',
            std: subType,
            onPress: () {
              type = 'earning';
              subType = '工资';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.dagong,
            label: '打工',
            std: subType,
            onPress: () {
              type = 'earning';
              subType = '打工';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.jiangjin,
            label: '奖金',
            std: subType,
            onPress: () {
              type = 'earning';
              subType = '奖金';
              setState(() {});
            },
          ),
          SubtypeOptionButton(
            imagePath: AppAssets.qita,
            label: '其他 ',
            std: subType,
            onPress: () {
              type = 'earning';
              subType = '其他 ';
              setState(() {});
              print(type);
            },
          ),
        ],
      ),
    );
  }

  _imagePage() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          GestureDetector(
            onTap: () async {
              if (image == null) {
                File? file = await pickImage();
                if (file != null) {
                  Get.offNamed(
                    AppRouter.cropImage,
                    arguments: {'image': file.path},
                  );
                }
              } else {
                AppTools.showPopup(context, widget: image!);
              }
            },
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppTheme.themeColor),
              ),
              child: image ??
                  const Center(
                    child: Text(
                      '暂无图片',
                      style: TextStyle(color: AppTheme.lightGrey, fontSize: 18),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
