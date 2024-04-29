// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:web_admin/common/page_info.dart';
import './right_style.dart';

import '../core.dart';

class Right extends StatefulWidget {
  const Right({super.key});

  @override
  State<Right> createState() => RightState();
}

class RightState extends State<Right> with TickerProviderStateMixin {
  late ScrollController _scrollController2;

  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        toolbar(),
        Expanded(child: visiblePage()),
      ],
    ));
  }

  StreamBuilder<String> visiblePage() {
    return StreamBuilder(
        stream: Core.instance.pageControllerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          print(snapshot);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return container('显示数据信息');
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return container('Error');
              } else if (snapshot.hasData) {
                try {
                  var entry2 = Core.instance.pageMap.entries.firstWhere((entry) => entry.value.name == snapshot.data.toString());
                  return entry2.value.widget;
                } catch (e) {
                  return container(snapshot.data.toString());
                }
              } else {
                return container('Empty data');
              }
            default:
              return container('State: ${snapshot.connectionState}');
          }
        });
  }

  StreamBuilder<String> toolbar() {
    return StreamBuilder(
      stream: Core.instance.btnControllerAction.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(top: 6, bottom: 6),
              child: SingleChildScrollView(
                controller: _scrollController2,
                primary: false,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Core.instance.pageMap.entries.where((entry) => entry.value.isActive).map((entry) {
                    return Container(
                      height: 24.0 * 1.0,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: entry.value.name == Core.instance.selectedNodeName ? Core.instance.selectedColor : Colors.deepOrange[100],
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: buttonStyle,
                            child: text(entry.value.name),
                            onPressed: () => _handleSelection(entry),
                          ),
                          IconButton(
                            // style: buttonStyle,
                            iconSize: 12,
                            hoverColor: Colors.lightGreen,
                            color: Colors.grey[700],
                            onPressed: () => _handleIconButton(entry),
                            icon: const Icon(Icons.close_outlined),
                          ),
                        ],
                      ),
                    );

                  }).toList(),
                ),
              ),
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );

  }

  void _handleSelection(MapEntry<String, PageInfo> entry) {
    String k = entry.value.name;
    Core.instance.selectedNodeName = k;
    Core.instance.notifyBtns(k);
    Core.instance.notifyPage(k);
    Core.instance.notifyItem(k);
  }

  void _handleIconButton(MapEntry<String, PageInfo> entry) {
    entry.value.isActive = false;
    try {
      var activeEntry = Core.instance.pageMap.entries.firstWhere((entry) => entry.value.isActive);

      var k = activeEntry.value.name;
      Core.instance.selectedNodeName = k;
      Core.instance.notifyItem(k);
      Core.instance.notifyPage(k);
      Core.instance.notifyBtns(k);
    } catch (e) {
      Core.instance.notifyPage('显示数据信息');
      Core.instance.notifyBtns('清空');
    }
  }
}
