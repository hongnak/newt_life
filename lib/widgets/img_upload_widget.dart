import 'package:flutter/material.dart';

Widget imgUploadWidget(model) {
  Widget widget = GestureDetector(
    onTap: () async => await model.pickImage(),
    child: SizedBox(
      width: 130.0,
      height: 100.0,
      child: model.imageFile != null
          ? Image.file(model.imageFile!)
          : Container(color: Colors.grey[200], child: const Icon(Icons.add_a_photo, size: 35.0, color: Colors.grey)),
    ),
  );
  return widget;
}