import 'package:flutter/material.dart';
import '../common/page_info.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_indexstack.dart';
import '../view/page3.dart';

import '../view/p_keep_live.dart';

List<PageInfo> lst = [
  PageInfo(name: '照片', widget: const P1()),
  PageInfo(name: '留言薄', widget: const P2()),
  PageInfo(name: '天津', widget: Page3()),
  PageInfo(name: '重庆', widget: const SAreaAgeGenderMain()),
  PageInfo(name: '大西洋', widget: const TestIndexStack()),
];



