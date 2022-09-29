import 'package:flutter/material.dart';
import 'package:newt_life/widgets/data_category_DDMIs.dart';

Widget selectCategoryWidget(model, String label, String hintText) {
  Widget widget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      DropdownButtonFormField(
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(1.5)
            )
        ),
        value: model.category,
        items: dataCategoryDDMIs,
        onChanged: (text) => model.category = text as String,
      ),
    ],
  );
  return widget;
}