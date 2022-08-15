import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:carrot_market_by_flutter/screens/base_screen.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [BeamPage(child: BaseScreen(stateValue: 'base home',), key: ValueKey('home'))];
  }

  @override
  // TODO: implement pathPatterns
  List<Pattern> get pathPatterns => ['/'];
}
