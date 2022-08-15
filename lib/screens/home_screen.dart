import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final _routeDelegate = BeamerDelegate(locationBuilder: BeamerLocationBuilder(beamLocations: ));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: _routeDelegate,
    );
  }
}
