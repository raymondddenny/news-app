import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/controller/providers/user_change_notifier.dart';
import 'package:flutter_testing_tutorial/services/dio/api_client/dio_api_client.dart';
import 'package:flutter_testing_tutorial/services/req_rest/user_services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/req_res_page/req_res_page.dart';

void main() {
  final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ReqResPage(),
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
      create: (_) => UserChangeNotifier(UserServices(dioApiClient: DioApiClient())),
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'ReqRes App',
      ),
    );
  }
}
