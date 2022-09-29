import 'package:flutter/material.dart';
import 'package:newt_life/domain/creature.dart';
import 'package:newt_life/domain/diary.dart';
import 'package:newt_life/domain/feed.dart';
import 'package:newt_life/domain/plant.dart';
import 'package:newt_life/domain/temperature.dart';
import 'package:newt_life/domain/waterChange.dart';
import 'package:newt_life/tank_detail/tank_detail_model.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:newt_life/widgets/creature_list_widget.dart';
import 'package:newt_life/widgets/data_list_widget.dart';
import 'package:newt_life/widgets/tank_detail_widget.dart';
import 'package:provider/provider.dart';

class TankDetailPage extends StatelessWidget {
  const TankDetailPage({Key? key, required this.tankID}) : super(key: key);
  final String tankID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TankDetailModel>(
      create: (_) => TankDetailModel(tankID: tankID)..fetchData(),
      child: Consumer<TankDetailModel>(builder: (context, model, child) {
        final List<Creature>? creatures = model.creatures;
        final List<Plant>? plants = model.plants;
        final List<WaterChange>? waterChanges = model.waterChanges;
        final List<Feed>? feeds = model.feeds;
        final List<Temperature>? temperatures = model.temperatures;
        final List<Diary>? diaries = model.diaries;
        if (creatures == null || plants == null || waterChanges == null || feeds == null || temperatures == null || diaries == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: appBar(model.name!),
          body: Align(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  tankDetailWidget(model, context, model.name!, model.size!, model.memo!, model.imgURL!, tankID),
                  creatureListWidget(model, context, creatures, '生き物', tankID, model.name!),
                  creatureListWidget(model, context, plants, '水草', tankID, model.name!),
                  dataListWidget(model, context, waterChanges, '水交換', tankID, 0, model.name!),
                  dataListWidget(model, context, feeds, '餌やり', tankID, 1, model.name!),
                  dataListWidget(model, context, temperatures, '水温', tankID, 2, model.name!),
                  dataListWidget(model, context, diaries, '日記', tankID, 3, model.name!),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}