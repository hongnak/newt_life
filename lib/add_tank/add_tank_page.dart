import 'package:flutter/material.dart';
import 'package:newt_life/add_tank/add_tank_model.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:newt_life/widgets/enter_button_widget.dart';
import 'package:newt_life/widgets/img_upload_widget.dart';
import 'package:newt_life/widgets/memo_entry_widget.dart';
import 'package:newt_life/widgets/name_entry_widget.dart';
import 'package:newt_life/widgets/select_size_widget.dart';
import 'package:provider/provider.dart';

class AddTankPage extends StatelessWidget {
  const AddTankPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTankModel>(
      create: (_) => AddTankModel(),
      child: Scaffold(
        appBar: appBar('水槽を追加'),
        body: Consumer<AddTankModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          imgUploadWidget(model),
                          nameEntryWidget(model, '水槽の名前', '入力してください'),
                          selectSizeWidget(model, '水槽のサイズ', '選択してください'),
                          const SizedBox(height: 16.0),
                          memoEntryWidget(model, 'メモ', '入力してください'),
                          const SizedBox(height: 16.0),
                          enterButtonWidget(model, context, '追加する', 'none', 'none')
                        ],
                      )
                    ),
                    if (model.isLoading) Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
                  ]
              ),
            );
          },
        ),
      ),
    );
  }

}