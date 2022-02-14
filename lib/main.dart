import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_testing_tutorial/controller/providers/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/pages/news_page/news_page.dart';
import 'package:flutter_testing_tutorial/services/news_service.dart';

void main() {
  final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const NewsPage(),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
              child: Scaffold(
            key: state.pageKey,
            body: Center(
              child: Text(state.error.toString()),
            ),
          )));
  runApp(MyApp(
    router: _router,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsChangeNotifier(NewsService()),
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'News App',
      ),
    );
  }
}
