import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:flutter_toolbox/generated/i18n.dart' as toolbox;

import 'paginated_list_view_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          indicator: TabRoundedLineIndicator(
            context,
            indicatorSize: TabRoundedLineIndicatorSize.normal,
            indicatorHeight: 3,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    ConnectionStatusBar.init(context);
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return DefaultTabController(
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
            labelColor: themeData.primaryColor,
            unselectedLabelColor: Color(0xff5f6368),
            isScrollable: true,
            indicator: TabRoundedLineIndicator(
              context,
              indicatorSize: TabRoundedLineIndicatorSize.normal,
              indicatorHeight: 3,
              indicatorColor: Theme.of(context).primaryColor,
            ),
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Personal info"),
              Tab(text: "Data & personalization"),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => push(context, PaginatedListViewPage()),
              child: Text('PaginatedList page'),
            )
          ],
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Text(toolbox.S.of(context).please_check_your_connection),
          );
        }),
      ),
    );
  }
}
