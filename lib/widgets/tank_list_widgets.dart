import 'package:flutter/material.dart';
import 'package:newt_life/tank_detail/tank_detail_page.dart';

List<Widget> tankListWidgets(List<dynamic> tanks, BuildContext context, model) {
  final List<Widget> widgets = tanks.map((tank) => Card(
    child: InkWell(
      onTap: () async {
        final bool? deleted = await Navigator.push(context, MaterialPageRoute(builder: (context) => TankDetailPage(tankID: tank.id)));
        if (deleted != null && deleted) {
          final snackBar = SnackBar(backgroundColor: Colors.green, content: Text('水槽を削除しました'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        model.fetchTankList();
      },
      child: Column(
        children: <Widget>[
          Text(tank.name),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      tank.imgURL != ''
                          ? SizedBox(height: 140, width: 170, child: Image.network(tank.imgURL, fit: BoxFit.cover))
                          : Container(color: Colors.grey[200], child: const SizedBox(height: 140, width: 170, child: Center(child: Text('No Image')))
                      ),
                      Text('サイズ  ${tank.size}', style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                Container(height: 140, width: 130, alignment: Alignment.centerLeft, child: Text(tank.memo, maxLines: 7, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)))
              ],
            ),
          ),
        ],
      ),
    ),
  )).toList();
  return widgets;
}