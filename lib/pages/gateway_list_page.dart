import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/components/custom_scaffold.dart';
import 'package:gateway_manager_client/components/gateway_list_component.dart';

class GatewayListPage extends ConsumerWidget {
  const GatewayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomScaffold(
      text: "Gateway list",
      child: GatewayListComponent(),
    );
  }
}
