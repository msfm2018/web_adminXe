import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/values/colors.dart';

class P3Data {
  var myTitle = 'mytitile';
  int i = 0;
}

class Page3 extends StatefulWidget {
  Page3({super.key});

  // String name = '';

  @override
  P3State createState() => P3State();
}

class P3State extends State<Page3> {
  StreamController<String> ss = StreamController();
  P3Data? p3Data;
  @override
  void dispose() {
    ss.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var tt = PageStorage.of(context).readState(context, identifier: widget.key);
    if (tt != null) {
      p3Data = tt;
    } else {
      p3Data = P3Data();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: const Text(
            '系统方法',
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              height: 1.3,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.topCenter,
          height: 400,
          width: MediaQuery.of(context).size.width / 2,
          // decoration:              BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StreamBuilder(
                  stream: ss.stream,
                  initialData: '---',
                  builder: (context, snapshot) {
                    return Text(p3Data == null ? "" : p3Data!.myTitle);
                    //  return Text(m(widget.name) == null ? "" : m(widget.name).myTitle);
                  }),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  ///框架自带方法 数据持久化
                  // m(widget.name).myTitle = '值:' + m(widget.name).i.toString() + '';

                  // ss.add(m(widget.name).myTitle);

                  //m(widget.name).i++;

                  ///系统自带方法数据持久化
                  p3Data!.myTitle = "我CAO ${p3Data!.i}";

                  p3Data!.i++;
                  ss.add(p3Data!.myTitle);

                  PageStorage.of(context).writeState(context, p3Data, identifier: widget.key);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color.fromARGB(255, 41, 103, 255);
                    }
                    return const Color.fromARGB(155, 41, 103, 255);
                  }),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                ),
                child: const Text('测试页面切换数据持久化333'),
              ),
            ],
          ),
        ),
        const Spacer(),
        MaterialButton(
          onPressed: btnState(false),
          disabledColor: Colors.grey,
          color: Colors.red,
          child: const Text('禁用按钮'),
        ),
      ],
    );
  }

  btnState(f) {
    if (f) {
      return () {
        if (kDebugMode) {
          print("you");
        }
      };
    } else {
      if (kDebugMode) {
        print('null');
      }
      return null;
    }
  }
}
