import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newt_life/data_detail/data_detail_page.dart';
import 'package:newt_life/data_kind.dart';
import 'package:newt_life/see_more/see_more_page.dart';
import 'package:newt_life/widgets/add_data_button_widget.dart';

Widget dataListWidget(model, BuildContext context, List<dynamic> dataList, String title, String id, int index, String tankName) {
  List<Icon> icons = const [Icon(Icons.water_drop), Icon(Icons.dining), Icon(Icons.thermostat_sharp), Icon(Icons.mail)];

  double setWidgetHeight(dynamic dataList) {
    double num = 50;
    switch (dataList.length) {
      case 0:
        break;
      case 1:
        num = 100;
        break;
      case 2:
        num = 150;
        break;
      case 3:
        num = 200;
        break;
    }
    return num;
  }

  Widget widget = Card(
    child: Column(
      children: [
        ListTile(
          leading: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          trailing: dataList.length > 3
              ?
          TextButton(
            child: const Text('さらに表示', style: TextStyle(fontSize: 12.0)),
            onPressed: () {
              setDataKind(title);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeeMorePage(dataList: dataList, tankName: tankName, title: title, index: index, tankID: id)));
            },
          )
              :
          null
        ),
        dataList.isNotEmpty
            ?
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          height: dataList.length < 3
              ? setWidgetHeight(dataList)
              : 200,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataList.length > 3 ? 3 : dataList.length,
            itemBuilder: (_, i) => Card(
              child: ListTile(
                onTap: () {
                  setDataKind(title);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: id)));
                },
                leading: icons[index],
                title: Text(dataList[i].amount.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20)),
                trailing: Text(DateFormat.yMMMEd('ja').add_Hm().format(dataList[i].registrationDate.toDate()).toString(), style: const TextStyle(fontSize: 12)),
              ),
            ),
          ),
        )
            :
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2),
          child: const Text('登録がありません', style: TextStyle(fontSize: 12))
        ),
        addDataButtonWidget(model, context, title, id)
      ],
    ),
  );
  return widget;
}