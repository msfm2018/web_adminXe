import 'package:flutter/material.dart';

import 'home_style.dart';
import 'login.dart';
import 'tree_core/tree.dart';
import 'tree_core/left_items/left.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      drawer: getDrawer(context, const Left()),
      endDrawer: const CustomDrawer(
        title: '尾测试',
        children: [
          ListTile(
            title: Text('body', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.wallet),
          ),
        ],
      ),
      appBar: getAppBar(),
      body: const TreeWidget(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 117, 155, 119),
      automaticallyImplyLeading: false,
      leading: Tooltip(
          message: '主页',
          child: IconButton(
            icon: const Icon(Icons.app_registration),
            onPressed: () {
              scaffoldStateKey.currentState!.openDrawer();
            },
          )),
      title:const Text('后台管理框架', style: TextStyle(color: Colors.white)),
      actions: <Widget>[
        Tooltip(
          message: '设置',
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              scaffoldStateKey.currentState!.openEndDrawer();
            },
          ),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'exit',
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('退出'),
              ),
            ),
          ],
          onSelected: ( v) {
            switch (v) {
              case 'exit':
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("确认退出"),
                      content: const Text("您确定要退出应用吗？"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("取消"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute<void>(builder: (BuildContext context) => const Login()),
                              ModalRoute.withName('/'),
                            );
                          },
                          child: const Text("确定"),
                        ),
                      ],
                    );
                  },
                );
                break;
            }
          },
        ),
      ],
    );
  }
}
