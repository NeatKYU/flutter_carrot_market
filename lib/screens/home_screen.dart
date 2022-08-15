import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:carrot_market_by_flutter/router/locations.dart';

final _routeDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [HomeLocation()],
  ),
);

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
