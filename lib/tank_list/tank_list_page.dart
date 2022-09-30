import 'package:flutter/material.dart';
import 'package:newt_life/add_tank/add_tank_page.dart';
import 'package:newt_life/domain/tank.dart';
import 'package:newt_life/setting/setting_page.dart';
import 'package:newt_life/tank_list/tank_list_model.dart';
import 'package:newt_life/widgets/tank_list_widgets.dart';
import 'package:provider/provider.dart';

class TankListPage extends StatelessWidget {
  const TankListPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TankListModel>(
      create: (_) => TankListModel()..fetchTankList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('水槽リスト'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage(), fullscreenDialog: true));
                },
                icon: const Icon(Icons.settings)
            )
          ],
        ),
        body: Consumer<TankListModel>(
          builder: (context, model, child) {
            final List<Tank>? tanks = model.tanks;

            if (tanks == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (tanks.isEmpty) {
              return const Center(child: Text('水槽がまだ一つも登録されていません'));
            }

            return ListView(children: tankListWidgets(tanks, context, model));
          },
        ),

        floatingActionButton: Consumer<TankListModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTankPage(title: '水槽を追加',), fullscreenDialog: true));
                  if (added != null && added) {
                    const snackBar = SnackBar(backgroundColor: Colors.green, content: Text('水槽を追加しました'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  model.fetchTankList();
                },
              );
            }
        ),
      ),
    );
  }
}