import 'package:flutter/material.dart';
import 'package:newt_life/data_detail/data_detail_model.dart';
import 'package:newt_life/data_kind.dart';
import 'package:newt_life/widgets/detail_data_widget.dart';
import 'package:newt_life/widgets/edit_data_button.dart';
import 'package:provider/provider.dart';

class DetailDataPage extends StatelessWidget {
  const DetailDataPage({Key? key, required this.data, required this.tankName, required this.tankID, required this.kind}) : super(key: key);
  final dynamic data;
  final String tankName;
  final String tankID;
  final String kind;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailDataModel>(
      create: (_) => DetailDataModel(tankID: tankID, docID: data.id)..fetchData(),
      child: Consumer<DetailDataModel>(builder: (context, model, child) {
        String? name;
        String? kinds;
        String? imgURL;
        String? memo;
        String? category;
        int? amountInt;
        dynamic amount;
        double? temperature;
        DateTime? registrationDate;
        DateTime? lastUpdatedDate;

        if (dataKind == DataKind.creature || dataKind == DataKind.plant) {
          name = model.name;
          kinds = model.kinds;
          imgURL = model.imgURL;
          category = model.category;
          amountInt = model.amountInt;
          if (name == null || kinds == null || imgURL == null || category == null) {
            return CircularProgressIndicator();
          }
        }

        if (dataKind == DataKind.waterChange || dataKind == DataKind.feed) {
          amount = model.amount;
          if (amount == null) return CircularProgressIndicator();
        }

        if (dataKind == DataKind.temperature) {
          temperature = model.temperature;
        }

        if (dataKind == DataKind.diary) {
          imgURL = model.imgURL;
          if (imgURL == null) return CircularProgressIndicator();
        }

        memo = model.memo;
        registrationDate = model.registrationDate;
        lastUpdatedDate = model.lastUpdatedDate;

        if (memo == null || registrationDate == null || lastUpdatedDate == null) {
          return CircularProgressIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(tankName),
            actions: [
              (dataKind == DataKind.creature || dataKind == DataKind.plant)
                  ? editDataButton(context, model, data.name, data.id, kind, tankID)
                  : editDataButton(context, model, kind, data.id, kind, tankID)
            ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(child: detailDataWidget(name, kinds, category, memo, amount, amountInt, imgURL, temperature, registrationDate, lastUpdatedDate, context))
          ),
        );
      }),
    );
  }
}