import 'package:bookkeeping/form/calendar.dart';
import 'package:bookkeeping/form/form.dart';
import 'package:bookkeeping/home/bill.dart';
import 'package:bookkeeping/home/home.dart';
import 'package:bookkeeping/home/search.dart';
import 'package:bookkeeping/home/search_result.dart';
import 'package:bookkeeping/keeping/add_bill.dart';
import 'package:bookkeeping/keeping/crop_image.dart';
import 'package:bookkeeping/keeping/exchange_rate.dart';
import 'package:bookkeeping/my/about_us.dart';
import 'package:bookkeeping/my/data_manage.dart';
import 'package:bookkeeping/my/login.dart';
import 'package:bookkeeping/my/my.dart';
import 'package:bookkeeping/my/my_achievement.dart';
import 'package:bookkeeping/my/register.dart';
import 'package:bookkeeping/plan/plan.dart';
import 'package:bookkeeping/plan/plan_detail.dart';
import 'package:bookkeeping/plan/plan_sub_type.dart';
import 'package:bookkeeping/root.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String root = '/';
  static const String home = '/home/';
  static const String bill = '/home/bill/';
  static const String search = '/home/search/';
  static const String searchResult = '/home/search/searchResult/';
  static const String form = '/form/';
  static const String calendar = '/form/calendar/';
  static const String cropImage = '/cropImage/';
  static const String addBill = '/addBill/';
  static const String exchangeRate = '/addBill/exchangeRate/';
  static const String plan = '/plan/';
  static const String planDetail = '/plan/planDetail/';
  static const String planSubType = '/plan/planDetail/planSubType/';
  static const String my = '/my/';
  static const String dataManage = '/my/dataManage/';
  static const String aboutUs = '/my/aboutUs/';
  static const String login = '/my/login/';
  static const String register = '/my/login/register/';
  static const String myAchievement = '/test/myAchievement/';

  static final List<GetPage> router = [
    GetPage(name: root, page: () => const AppRoot()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: bill, page: () => const BillPage()),
    GetPage(name: search, page: () => const SearchPage()),
    GetPage(name: searchResult, page: () => const SearchResultPage()),
    GetPage(name: form, page: () => const FormPage()),
    GetPage(name: calendar, page: () => const CalendarPage()),
    GetPage(name: cropImage, page: () => const CropImagePage()),
    GetPage(name: addBill, page: () => const AddBillPage()),
    GetPage(name: exchangeRate, page: () => const ExchangeRatePage()),
    GetPage(name: plan, page: () => const PlanPage()),
    GetPage(name: planDetail, page: () => const PlanDetailPage()),
    GetPage(name: planSubType, page: () => const PlanSubTypePage()),
    GetPage(name: my, page: () => const MyPage()),
    GetPage(name: aboutUs, page: () => const AboutUsPage()),
    GetPage(name: dataManage, page: () => const DataManagePage()),
    GetPage(name: myAchievement, page: () => const MyAchievementPage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
  ];

  // 底部导航栏的页面
  static List rootPage = [
    const HomePage(),
    const FormPage(),
    const CropImagePage(),
    const PlanDetailPage(),
    const MyPage(),
  ];
}
