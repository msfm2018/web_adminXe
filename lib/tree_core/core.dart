import 'dart:async';
import 'package:flutter/material.dart';

import '../common/page_info.dart';
import '../tree_config/config.dart';

typedef Wb<T> = Widget Function(T);




class Core extends State {

  Core._() {
    _instance = this;

    pageMap = <String, PageInfo>{};

    ///pageControllerAction
    pageControllerAction = StreamController.broadcast();
    btnControllerAction = StreamController.broadcast();
    itemControllerAction = StreamController.broadcast();
    Config.init();
  }

  static Core? _instance;
  factory Core() {
    return _instance ??= Core._();
  }

  static Core get instance => _getInstance();

  static Core _getInstance() {
    return _instance ?? Core._();
  }

//一共需要通知的三个地方 tree  右侧panel  button列表

// 右侧页面发生变化
  void notifyPage(String n) {
    pageControllerAction.add(n);
  }

// 左侧树发生变化
  void notifyItem(String n) {
    itemControllerAction.add(n);
  }

//标题栏按钮发生变化
  void notifyBtns(String n) {
    btnControllerAction.add(n);
  }

  bool isAllExpanded = false;
  var selectedNodeName = '';
  var selectedColor = Colors.blue[200];

  //3个地方需要update通知
  late StreamController<String> pageControllerAction;

  late StreamController<String> btnControllerAction;
  late StreamController<String> itemControllerAction;

  ///----------------------------------------------------
  ///页面配置
  late Map<String, PageInfo> pageMap;

  ///------------------------------------------------------
  @override
  Widget build(Object context) {
    return Container();
  }

  @override
  void dispose() {
    pageControllerAction.close();
    btnControllerAction.close();
    itemControllerAction.close();
    super.dispose();
  }
}
