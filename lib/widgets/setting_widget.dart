import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

Widget settingWidget() {
  const String shareText = 'https://apps.apple.com/jp/app/%E7%8C%ABya%E8%90%8C%E6%97%A5%E8%AF%ADquiz/id1563615513';
  Icon arrowIcon = const Icon(Icons.arrow_forward_ios_sharp, size: 16);

  Widget widget = ListView(
    children: [
      ListTile(
          leading: const Icon(Icons.notification_important_outlined),
          title: const Text('お知らせ'),
          trailing: arrowIcon
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.mail_outline),
          title: const Text('お問い合わせ'),
          trailing: arrowIcon
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.rate_review_outlined),
          title: const Text('アプリをレビュー'),
          trailing: arrowIcon
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.ios_share),
          title: const Text('友達に教える'),
          trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 16),
          onTap: () {
            Share.share(shareText);
          }
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.rule_outlined),
          title: const Text('利用規約'),
          trailing: arrowIcon
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.numbers_outlined),
          title: const Text('アプリバージョン'),
          trailing: arrowIcon
      ),
      const Divider(),
    ],
  );
  return widget;
}