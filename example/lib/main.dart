import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolbox/generated/i18n.dart' as toolbox;
import 'package:flutter_toolbox/flutter_toolbox.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        toolbox.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale("en", ""),
        Locale("ar", ""),
      ],
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Plugin example app',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Color(0xff1967d2),
              unselectedLabelColor: Color(0xff5f6368),
              isScrollable: true,
              indicator: TabRoundedLineIndicator(
                indicatorSize: TabRoundedLineIndicatorSize.full,
                indicatorHeight: 3,
                indicatorColor: Color(0xff1967d2),
              ),
              tabs: <Widget>[
                Tab(
                  text: "Home",
                ),
                Tab(
                  text: "Personal info",
                ),
                Tab(
                  text: "Data & personalization",
                ),
              ],
            ),
          ),
          body: Center(
              //          child: Text(toolbox.S.of(context).please_check_your_connection),
              ),
        ),
      ),
    );
  }
}
