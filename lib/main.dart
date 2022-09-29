import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:newt_life/reminder_list/remidner_list_page.dart';
import 'package:newt_life/tank_list/tank_list_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newt Life',
      theme: ThemeData(
        textTheme: GoogleFonts.mPlusRounded1cTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: const [Locale("en"), Locale("ja")],
      home: const MyHomePage(title: 'いもり生活'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  final _pages = <Widget>[const TankListPage(title: '水槽リスト'), const ReminderListPage(title: 'リマインダ')];

  Future<void> _anonymousSignIn() async {
    UserCredential anonymousUser = await _auth.signInAnonymously();
    if (kDebugMode) {
      print('uid: ${anonymousUser.user!.uid}');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _anonymousSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_sharp), label: "水槽"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "リマインダ"),
        ],
      ),
    );
  }
}
