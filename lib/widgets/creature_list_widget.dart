import 'package:flutter/material.dart';
import 'package:newt_life/data_detail/data_detail_page.dart';
import 'package:newt_life/data_kind.dart';
import 'package:newt_life/widgets/add_data_button_widget.dart';

Widget creatureListWidget(model, BuildContext context, List<dynamic> dataList, String title, String id, String tankName) {
  Widget widget = Card(
    child: Column(
      children: [
        ListTile(leading: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        dataList.isNotEmpty
            ?
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
              height: 120.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => Column(
                  children: [
                    GestureDetector(
                      child: dataList[i].imgURL != ''
                          ?
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(dataList[i].imgURL)))
                      )
                          :
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]), child: const Center(child: Text('No Image'))
                      ),
                      onTap: () {
                        setDataKind(title);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: id)));
                      },
                    ),
                    Text(dataList[i].name, overflow: TextOverflow.ellipsis)
                  ],
                ),
                separatorBuilder: (BuildContext context, int i) => const SizedBox(width: 10.0),
                itemCount: dataList.length
              ),
            ),
            addDataButtonWidget(model, context, title, id)
          ],
        )
            :
        Column(
          children: [
            Container(
                // height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                child: const Text('登録がありません', style: TextStyle(fontSize: 12))
            ),
            addDataButtonWidget(model, context, title, id)
          ],
        ),
      ],
    ),
  );
  return widget;
}