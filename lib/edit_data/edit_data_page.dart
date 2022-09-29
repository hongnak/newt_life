import 'package:flutter/material.dart';
import 'package:newt_life/data_kind.dart';
import 'package:newt_life/edit_data/edit_data_model.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:newt_life/widgets/enter_button_widget.dart';
import 'package:newt_life/widgets/img_upload_widget.dart';
import 'package:newt_life/widgets/kind_entry_widget.dart';
import 'package:newt_life/widgets/memo_entry_widget.dart';
import 'package:newt_life/widgets/name_entry_widget.dart';
import 'package:newt_life/widgets/select_amount_widget.dart';
import 'package:newt_life/widgets/select_category_widget.dart';
import 'package:newt_life/widgets/select_date_widget.dart';
import 'package:provider/provider.dart';

class EditDataPage extends StatelessWidget {
  const EditDataPage({Key? key, required this.kind, required this.tankID, required this.docID, required this.name}) : super(key: key);
  final String kind;
  final String tankID;
  final String docID;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('$nameを編集'),
      body: ChangeNotifierProvider<EditDataModel>(
        create: (_) => EditDataModel(tankID: tankID, docID: docID)..fetchData(),
        child: SingleChildScrollView(
          child: Consumer<EditDataModel>(builder: (context, model, child) {
            const String entryStr = '入力してください';
            const String selectStr = '選択してください';
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (dataKind == DataKind.creature || dataKind == DataKind.plant)
                        Column(
                          children: [
                            imgUploadWidget(model),
                            nameEntryWidget(model, '$kindの名前', entryStr),
                            selectCategoryWidget(model, '$kindのカテゴリー', selectStr),
                            const SizedBox(height: 16.0),
                            kindEntryWidget(model, '$kindの種類', entryStr),
                            selectAmountWidget(model, context, '$unitName数', selectStr),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '追加日'),
                            const SizedBox(height: 16.0),
                            memoEntryWidget(model, 'メモ', entryStr)
                          ],
                        ),
                      if (dataKind == DataKind.waterChange || dataKind == DataKind.feed)
                        Column(
                          children: [
                            selectAmountWidget(model, context, '$kind量', selectStr),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '$kind日'),
                            const SizedBox(height: 16.0),
                            memoEntryWidget(model, 'メモ', entryStr)
                          ],
                        ),
                      if (dataKind == DataKind.temperature)
                        Column(
                          children: [
                            selectAmountWidget(model, context, kind, selectStr),
                            const SizedBox(height: 16.0),
                            selectDateWidget(model, context, '測定日'),
                            const SizedBox(height: 16.0),
                            memoEntryWidget(model, 'メモ', entryStr)
                          ],
                        ),
                      if (dataKind == DataKind.diary)
                        Column(
                          children: [
                            imgUploadWidget(model),
                            selectDateWidget(model, context, '記録日'),
                            const SizedBox(height: 16.0),
                            memoEntryWidget(model, '日記', entryStr)
                          ],
                        ),
                      const SizedBox(height: 16.0),
                      enterButtonWidget(model, context, '編集する', docID, collectionName)
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}