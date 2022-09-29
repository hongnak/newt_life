import 'package:flutter/material.dart';
import 'package:newt_life/add_data/add_data_page.dart';
import 'package:newt_life/data_kind.dart';

Widget addDataButtonWidget(model, BuildContext context, String kind, String id) {
  Widget widget = Center(
    child: IconButton(
      onPressed: () async {
        setDataKind(kind);
        final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataPage(kind: kind, id: id), fullscreenDialog: true));
        if (added != null && added) {
          final snackBar = SnackBar(backgroundColor: Colors.green, content: Text("$kindを追加しました"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        model.fetchData();
      },
      icon: Icon(Icons.add_circle, color: Colors.grey[400]),
    ),
  );
  return widget;
}