import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newt_life/data_detail/data_detail_page.dart';
import 'package:newt_life/data_kind.dart';

Widget seeMoreWidget(dynamic dataList, String title, BuildContext context, String tankName, int index, String tankID) {
  List<Icon> icons = const [Icon(Icons.water_drop), Icon(Icons.dining), Icon(Icons.thermostat_sharp), Icon(Icons.mail)];
  Widget widget = ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: dataList.length,
    itemBuilder: (_, i) {
      return Card(
        child: ListTile(
          onTap: () {
            setDataKind(title);
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: tankID)));
          },
          leading: icons[index],
          title: Text(dataList[i].amount.toString(), style: const TextStyle(fontSize: 20)),
          trailing: Text(DateFormat.yMMMEd('ja').add_Hm().format(dataList[i].registrationDate.toDate()).toString(), style: const TextStyle(fontSize: 12)),
        ),
      );
    }
  );
  return widget;
}