import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:carrot_market_by_flutter/router/locations.dart';
import 'package:carrot_market_by_flutter/screens/base_screen.dart';
import 'package:carrot_market_by_flutter/screens/splash_screen.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';

void main() {
  logger.d('this is logger debug!!');
  runApp(MyApp());
}

final _routeDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [HomeLocation()],
  ),
);

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
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: _routeDelegate,
    );
  }
}

