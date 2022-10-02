import 'package:carrot_market_by_flutter/model/item_model/item_model.dart';
import 'package:carrot_market_by_flutter/provider/category_provider.dart';
import 'package:carrot_market_by_flutter/provider/select_images_provider.dart';
import 'package:carrot_market_by_flutter/screens/chat/chatroom_screen.dart';
import 'package:carrot_market_by_flutter/screens/input/category_input_screen.dart';
import 'package:carrot_market_by_flutter/screens/input/input_sreen.dart';
import 'package:carrot_market_by_flutter/screens/item/item_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carrot_market_by_flutter/screens/base_screen.dart';
import 'package:carrot_market_by_flutter/screens/splash_screen.dart';
import 'package:carrot_market_by_flutter/screens/auth_screen.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/screens/home_scren.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          Duration(seconds: 0),
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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => SelectImagesProvider())
        ],
        child: ChangeNotifierProvider<UserProvider>.value(
          value: userState,
          child: MaterialApp.router(
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'DoHyeon',
              hintColor: Colors.grey,
              textTheme: const TextTheme(
                button: TextStyle(color: Colors.white),
                headline1: TextStyle(color: Colors.black, fontSize: 20),
                subtitle1: TextStyle(color: Colors.blueGrey, fontSize: 15),
                subtitle2: TextStyle(color: Colors.grey, fontSize: 12),
                bodyText2: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  // 이걸 설정하면 눌렀을때 이펙트가 white색으로 보임
                  primary: Colors.white,
                ),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 2,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DoHyeon',
                  color: Colors.black,
                ),
                actionsIconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.black87,
                unselectedItemColor: Colors.black38,
              ),
            ),
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: 'GoRouter Example',
          ),
        ),
      );

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
        // 이렇게 라우터를 타면 appbar에 뒤로가기 버튼이 생김
        routes: [
          GoRoute(
            path: 'input',
            builder: (BuildContext context, GoRouterState state) {
              return InputScreen();
            },
            routes: [
              GoRoute(
                path: 'category',
                builder: (BuildContext context, GoRouterState state) {
                  return CategoryInputScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'item/:item_key',
            builder: (BuildContext context, GoRouterState state) {
              return ItemDetailScreen(state.params['item_key']!);
            },
          ),
          GoRoute(
            path: 'item/:item_key/:chatroom_key',
            builder: (BuildContext context, GoRouterState state) {
              return ChatroomScreen(state.params['chatroom_key']!);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return AuthScreen();
        },
      ),
    ],
    redirect: (GoRouterState state) {
      // 여기서 provider를 사용하기 위해 router를 provider변수와 같은 레벨에 위치시킴
      // if the user is not logged in, they need to login
      // final loggedIn = userState.loggedIn;
      // 로그인 하려는 중인가?
      final loggingIn = state.subloc == '/login';
      if (userState.user == null) return loggingIn ? null : '/login';
      // if (loggedIn) return loggingIn ? null : '/login';

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) return '/';

      return null;
    },
    refreshListenable: userState,
  );
}
