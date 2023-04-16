import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'SEG-X5 Configuration',
          'prepare': 'Before start',
          'tip1': '1. Power the gateway on and connect it to Ethernet cable.',
          'tip2':
              '2. Please make sure your phone(or pc) and the gateway are connected to the same router.',
          'tip3':
              '3. Press and hold both the ZigBee button and the Wi-Fi button for 5S until the buzzer beep twice quickly, and then release it to wait for the Internet indicator turn to orange always-on state and start the configuration.',
          'config': 'Start configuration',
          'find_mac': 'Scanned gateway mac: ',
          'connect_state': 'Gateway connection state：',
          'config_state': 'Gateway configuration state：',
          'connect_success': 'Connect success',
          'config_success': 'Config success',
          'scan_first': 'Please scan the gateway first',
          'connect_first': 'Please connect to the gateway first',
        },
        'zh_CN': {
          'title': 'X5网关配置工具',
          'prepare': '准备工作',
          'tip1': '1. 请将网关上电并插上网线。',
          'tip2': '2. 请确保客户端（pc, phone）和网关连接在同一个路由下。',
          'tip3':
              '3. 同时按住ZigBee键和Wi-Fi配网键5S，直到蜂鸣器快速嘀嘀2声后松开，等待互联网指示灯变橙灯常亮后开始扫描。',
          'config': '开始配置',
          'find_mac': '扫描到的网关mac: ',
          'connect_state': '网关连接状态：',
          'config_state': '网关配置状态：',
          'connect_success': '连接成功',
          'config_success': '配置成功',
          'scan_first': '请先扫描网关',
          'connect_first': '请先连接网关',
        }
      };
}
