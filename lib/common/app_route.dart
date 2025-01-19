import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/presentation/pages/dashboard.dart';
import 'package:course_travel/features/destination/presentation/pages/detail_destination.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const dashboard = '/';
  static const detailDestination = '/destination/detail';
  static const searchDestination = '/destination/search';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case detailDestination:
        final destination = settings.arguments;
        if (destination == null || destination is! DestinationEntity) {
          return _invalidArgumentPage;
        }
        return MaterialPageRoute(
            builder: (context) => DetailDestination(destination: destination));
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _invalidArgumentPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Invalid Argument'),
            ),
          ));
  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ));
}
