import 'package:flutter/material.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:newt_life/widgets/setting_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('設定'),
      body: Padding(padding: const EdgeInsets.all(8.0), child: settingWidget())
    );
  }

}