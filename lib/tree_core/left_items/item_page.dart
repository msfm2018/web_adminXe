import 'package:flutter/material.dart';
import 'package:web_admin/common/page_info.dart';
import '../core.dart';
import '../../tree_config/data_bean.dart';
import './item_page_style.dart';

class ItemPage extends StatefulWidget {
  final DataBean bean;
  const ItemPage(this.bean, {super.key});

  @override
  ItemPageState createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Core.instance.itemControllerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return ListTile(
            title: _buildItem(widget.bean),
          );
        });
  }

  Widget _buildItem(DataBean bean) {
    if (bean.children.isEmpty) {
      return Core.instance.selectedNodeName == bean.name
          ? TextButton(
              style: selectedButtonStyle,
              child: Text(bean.name),
              onPressed: () {
                var entry2 = Core.instance.pageMap.entries.firstWhere((entry) => entry.value.name == bean.name);
                entry2.value.isActive = true;

                Core.instance.selectedNodeName = bean.name;
                Core.instance.notifyBtns(bean.name);
                Core.instance.notifyPage(bean.name);
                Core.instance.notifyItem(bean.name);
              },
            )
          : TextButton(
              style: buttonStyle,
              child: Text(bean.name),
              onPressed: () {
                MapEntry<String, PageInfo> entry2;
                try {
                  entry2 = Core.instance.pageMap.entries.firstWhere((entry) => entry.value.name == bean.name);
                  entry2.value.isActive = true;

                  Core.instance.selectedNodeName = bean.name;
                  Core.instance.notifyBtns(bean.name);
                  Core.instance.notifyPage(bean.name);
                  Core.instance.notifyItem(bean.name);
                } catch (e) {
                  debugPrint('error:-->Core.instance.pageMap.entries.firstWhere((entry) => entry.value.name == bean.name)');
                }
              },
            );
    }

    return ExpansionTile(
      key: PageStorageKey<DataBean>(bean),
      title: Text(
        bean.name,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          bean.name.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      children: bean.children.map((e) => _buildItem(e)).toList(),
    );
  }
}
