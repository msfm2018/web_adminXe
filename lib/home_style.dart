
import 'package:flutter/material.dart';


Drawer getDrawer(context, left) {
  if (MediaQuery.of(context).size.width > 600) {
    return const Drawer(
      child: Center(
          child: Column(
            children: [

              DrawerHeader(
                  child: Text(
                    'header',
                    style: TextStyle(color: Colors.black),
                  )),
              Text(
                'This is Drawer',
                style: TextStyle(color: Colors.black),
              )
            ],
          )),
    );
  } else {
    return  Drawer(child: left);
  }
}

class CustomDrawer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomDrawer({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Text(title),
          ),
          ...children,
        ],
      ),
    );
  }
}


