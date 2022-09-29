import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newt_life/data_kind.dart';

Widget detailDataWidget(name, kinds, category, memo, amount, amountInt, imgURL, temperature, registrationDate, lastUpdatedDate, BuildContext context) {
  double labelWidth = MediaQuery.of(context).size.width * 0.3;
  double memoWidth = MediaQuery.of(context).size.width * 0.6;

  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
      Column(
        children: [
          imgURL != ''
              ? Center(child: Container(width: 250, height: 200, decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imgURL), fit: BoxFit.cover))))
              : Center(child: Container(width: 250, height: 200, color: Colors.grey[200], child: const Center(child: Text('No Image')))),
          const SizedBox(height: 15),
          const Divider(),
          Row(children: [SizedBox(width: labelWidth, child: const Text('名前', style: TextStyle(fontSize: 14))), Text(name)]),
          const Divider(),
          Row(children: [SizedBox(width: labelWidth, child: const Text('カテゴリ', style: TextStyle(fontSize: 14))), Text(category)]),
          const Divider(),
          Row(children: [SizedBox(width: labelWidth, child: const Text('種類', style: TextStyle(fontSize: 14))), Text(kinds)]),
          const Divider(),
        ]
      ),
      if (dataKind == DataKind.waterChange)
      Column(
        children: [
          Row(children: [SizedBox(width: labelWidth, child: const Text('水交換量', style: TextStyle(fontSize: 14))), Text(amount)]),
          const Divider(),
        ],
      ),
      if (dataKind == DataKind.feed)
        Column(
          children: [
            Row(children: [SizedBox(width: labelWidth, child: const Text('餌やり量', style: TextStyle(fontSize: 14))), Text(amount)]),
            const Divider(),
          ],
        ),
      if (dataKind == DataKind.temperature)
        Column(
          children: [
            Row(children: [SizedBox(width: labelWidth, child: const Text('水温', style: TextStyle(fontSize: 14))), Text('${temperature.toString()}°C')]),
            const Divider(),
          ],
        ),
      if (dataKind == DataKind.diary)
        Column(
          children: [
            imgURL != ''
                ? Center(child: Container(width: 250, height: 200, decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imgURL), fit: BoxFit.cover))))
                : Center(child: Container(width: 250, height: 200, color: Colors.grey[200], child: const Center(child: Text('No Image')))),
            const SizedBox(height: 15),
            const Divider(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SizedBox(width: labelWidth, height: 120, child: const Text('日記', style: TextStyle(fontSize: 14))), SizedBox(width: memoWidth, child: Text(memo, maxLines: 30, overflow: TextOverflow.ellipsis))]
            ),
            const Divider(),
          ],
        ),
      Row(children: [SizedBox(width: labelWidth, child: const Text('追加日', style: TextStyle(fontSize: 14))), Text(DateFormat.yMMMEd('ja').format(registrationDate).toString())]),
      const Divider(),
      Row(children: [SizedBox(width: labelWidth, child: const Text('最新更新日', style: TextStyle(fontSize: 14))), Text(DateFormat.yMMMEd('ja').format(lastUpdatedDate).toString())]),
      const Divider(),
      if (dataKind != DataKind.diary)
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SizedBox(width: labelWidth, height: 120, child: const Text('メモ', style: TextStyle(fontSize: 14))), SizedBox(width: memoWidth, child: Text(memo, maxLines: 30, overflow: TextOverflow.ellipsis))]
          ),
          const Divider(),
        ],
      ),
    ],
  );
  return widget;
}