import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/screens/base_screen.dart';
import 'package:carrot_market_by_flutter/screens/splash_screen.dart';
import 'package:carrot_market_by_flutter/screens/auth_screen.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/screens/home_scren.dart';

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
  Router({Key? key}) : super(key: key);

  final userState = UserProvider();

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<UserProvider>.value(
        value: userState,
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
              actionsIconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: 'GoRouter Example',
        ),
      );

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          logger.d(
              'context loggedIn = ${context.watch<UserProvider>().loggedIn}');
          return AuthScreen();
        },
      ),
    ],
    redirect: (GoRouterState state) {
      // 여기서 provider를 사용하기 위해 router를 provider변수와 같은 레벨에 위치시킴
      // if the user is not logged in, they need to login
      final loggedIn = userState.loggedIn;
      // 로그인 하려는 중인가?
      final loggingIn = state.subloc == '/login';
      if (!loggedIn) return loggingIn ? null : '/login';

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) return '/';

      return null;
    },
    refreshListenable: userState,
  );
}
