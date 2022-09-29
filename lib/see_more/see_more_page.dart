import 'package:flutter/material.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:newt_life/widgets/see_more_widget.dart';

class SeeMorePage extends StatelessWidget {
  const SeeMorePage({Key? key, required this.dataList, required this.tankName, required this.tankID, required this.title, required this.index}) : super(key: key);
  final dynamic dataList;
  final String tankName;
  final String tankID;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(tankName),
      body: seeMoreWidget(dataList, title, context, tankName, index, tankID),
    );
  }

}