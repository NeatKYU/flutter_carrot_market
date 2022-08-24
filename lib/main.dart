import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/screens/base_screen.dart';
import 'package:carrot_market_by_flutter/screens/splash_screen.dart';
import 'package:carrot_market_by_flutter/screens/auth_screen.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:provider/provider.dart';

void main() {
  logger.d('this is logger debug!!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  StatelessWidget _snapshotWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return BaseScreen(stateValue: 'error');
    } else if (snapshot.hasData) {
      return Router();
    } else {
      return const SplashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 3),
          () => 100,
        ),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(microseconds: 300),
            child: _snapshotWidget(snapshot),
          );
        },
      ),
    );
  }
}

class Router extends StatelessWidget {
  const Router({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'DoHyeon',
          hintColor: Colors.grey,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              // 이걸 설정하면 눌렀을때 이펙트가 white색으로 보임
              primary: Colors.white,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontFamily: 'DoHyeon',
              color: Colors.black,
            ),
          ),
        ),
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'GoRouter Example',
      ),
    );
  }
}

var _checkValue = false;

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return AuthScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return BaseScreen(
          stateValue: 'home page',
        );
      },
    ),
    // GoRoute(
    //   path: '/b',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return ScreenB();
    //   },
    // ),
  ],
  redirect: (GoRouterState state) {
    // if (_checkValue) return '/';
    // if (!_checkValue) {
    //   _checkValue = true;
    //   return '/login';
    // }
    return null;
  },
);
