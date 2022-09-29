import 'package:flutter/material.dart';
import 'package:newt_life/data_kind.dart';
import 'package:newt_life/widgets/feed_amount_DDMIs.dart';
import 'package:newt_life/widgets/waterChange_amount_DDMIs.dart';
import 'package:numberpicker/numberpicker.dart';

Widget selectAmountWidget(model, BuildContext context, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
        InkWell(
          child: TextField(
            controller: TextEditingController(text: '${model.amountInt}''$unitName'),
            textAlign: TextAlign.end,
            enabled: false,
            decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Colors.white,
                      child: NumberPicker(
                          minValue: 1,
                          maxValue: 200,
                          value: model.amountInt,
                          onChanged: (value) => model.setAmountInt(value))
                    )
                );
              }
          );
        },
      ),
      if (dataKind == DataKind.waterChange || dataKind == DataKind.feed)
        DropdownButtonFormField(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))
          ),
          value: model.amount,
          items: dataKind == DataKind.waterChange
              ? waterChangeAmountDDMIs
              : feedAmountDDMIs,
          onChanged: (text) {
            if (dataKind == DataKind.waterChange) {
              model.amount = text as String;
            } else {
              model.amount = text as String;
            }
          }
        ),
      if (dataKind == DataKind.temperature)
        InkWell(
          child: TextField(
            controller: TextEditingController(text: '${model.temperature}''°C'),
            textAlign: TextAlign.end,
            enabled: false,
            decoration: InputDecoration(border: OutlineInputBorder(gapPadding: 0.0, borderRadius: BorderRadius.circular(1.5))),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: Colors.white,
                          child: DecimalNumberPicker(minValue: 0, maxValue: 45, value: model.temperature, onChanged: (value) => model.setTemperature(value)),
                      )
                  );
                }
            );
          },
        ),
    ],
  );
  return widget;
}