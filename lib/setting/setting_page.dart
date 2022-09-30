import 'package:flutter/material.dart';
import 'package:newt_life/widgets/appbar.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('設定'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const ListTile(leading: Icon(Icons.notification_important_outlined), title: Text('お知らせ'), trailing: Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            const Divider(),
            const ListTile(leading: const Icon(Icons.mail_outline), title: const Text('お問い合わせ'), trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            const Divider(),
            const ListTile(leading: Icon(Icons.rate_review_outlined), title: Text('アプリをレビュー'), trailing: Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.ios_share),
                title: const Text('友達に教える'),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16),
                onTap: () {
                 Share.share('https://apps.apple.com/jp/app/%E7%8C%ABya%E8%90%8C%E6%97%A5%E8%AF%ADquiz/id1563615513');
                }
            ),
            const Divider(),
            const ListTile(leading: Icon(Icons.rule_outlined), title: const Text('利用規約'), trailing: Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            const Divider(),
            const ListTile(leading: const Icon(Icons.numbers_outlined), title: const Text('アプリバージョン'), trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16)),
            const Divider(),
          ],
        ),
      ),
    );
  }

}