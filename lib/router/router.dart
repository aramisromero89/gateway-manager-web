// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:gateway_manager_client/pages/gateway_detail_page.dart';
import 'package:gateway_manager_client/pages/gateway_list_page.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: GatewayListPage, initial: true),
    AutoRoute(
        path: "/gateway/:id", page: GatewayDetailPage, deferredLoading: true),
  ],
)
class $AppRouter {}
