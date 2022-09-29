import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newt_life/edit_tank/edit_tank_page.dart';

Widget editTankButton(BuildContext context, model, String name, String id) {
  Widget widget = IconButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                children: [
                  SimpleDialogOption(
                    onPressed: () async {
                      final bool? added = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditTankPage(title: '$nameを編集', tankID: id), fullscreenDialog: true));
                      if (added != null && added) {
                        final snackBar = SnackBar(backgroundColor: Colors.green, content: Text('$nameを編集しました'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      model.fetchData();
                      Navigator.of(context).pop();
                    },
                    child: const Text('編集する'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('データを削除します'),
                              content: const Text('この操作は取り消せません'),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('キャンセル')
                                ),
                                CupertinoDialogAction(
                                    onPressed: () async {
                                      try {
                                        model.startLoading();
                                        await model.deleteData();
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                      } catch (e) {
                                        if (kDebugMode) {
                                          print(e);
                                        }
                                        final snackBar = SnackBar(content: Text(e.toString()));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } finally {
                                        model.endLoading();
                                      }
                                    },
                                    child: const Text('OK')
                                ),
                              ],
                            );
                          }
                      );
                    },
                    child: const Text('削除する'),
                  ),
                ],
              );
            }
        );
      },
      icon: const Icon(Icons.more_horiz));
  return widget;
}