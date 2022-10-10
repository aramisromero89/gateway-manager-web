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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../pages/gateway_detail_page.dart' deferred as _i2;
import '../pages/gateway_list_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    GatewayListRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.GatewayListPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    GatewayDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GatewayDetailRouteArgs>(
          orElse: () => GatewayDetailRouteArgs(id: pathParams.getString('id')));
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.GatewayDetailPage(
            args.id,
            key: args.key,
          ),
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          GatewayListRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          GatewayDetailRoute.name,
          path: '/gateway/:id',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.GatewayListPage]
class GatewayListRoute extends _i3.PageRouteInfo<void> {
  const GatewayListRoute()
      : super(
          GatewayListRoute.name,
          path: '/',
        );

  static const String name = 'GatewayListRoute';
}

/// generated route for
/// [_i2.GatewayDetailPage]
class GatewayDetailRoute extends _i3.PageRouteInfo<GatewayDetailRouteArgs> {
  GatewayDetailRoute({
    required String id,
    _i4.Key? key,
  }) : super(
          GatewayDetailRoute.name,
          path: '/gateway/:id',
          args: GatewayDetailRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'GatewayDetailRoute';
}

class GatewayDetailRouteArgs {
  const GatewayDetailRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final _i4.Key? key;

  @override
  String toString() {
    return 'GatewayDetailRouteArgs{id: $id, key: $key}';
  }
}
