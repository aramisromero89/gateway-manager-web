// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../pages/gateway_list_page.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    GatewayListRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.GatewayListPage(),
        opaque: true,
        barrierDismissible: false,
      );
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          GatewayListRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [_i1.GatewayListPage]
class GatewayListRoute extends _i2.PageRouteInfo<void> {
  const GatewayListRoute()
      : super(
          GatewayListRoute.name,
          path: '/',
        );

  static const String name = 'GatewayListRoute';
}
