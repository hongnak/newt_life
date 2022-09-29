import 'package:flutter/material.dart';
import 'package:newt_life/widgets/edit_tank_button.dart';

Widget tankDetailWidget(model, BuildContext context, String name, String size, String memo, String imgURL, String id) {
  Widget widget = Card(
    child: Stack(
      children: [
        Column(
          children: [
            ListTile(
              leading: const Text('水槽' , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: editTankButton(context, model, name, id)
            ),
            imgURL != ''
                ? Container(width: 250, height: 200, decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imgURL), fit: BoxFit.cover)))
                : Container(width: 250, height: 200, color: Colors.grey[200], child: const Center(child: Text('No Image'))),
            Text('サイズ  $size'),
            Padding(padding: const EdgeInsets.all(8.0), child: Container(padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0), child: Text(memo))),
          ],
        )
      ],
    ),
  );
  return widget;
}