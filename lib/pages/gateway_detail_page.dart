import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/components/custom_scaffold.dart';
import 'package:gateway_manager_client/logic/gateway_detail_component.dart';

class GatewayDetailPage extends ConsumerWidget {
  final String id;
  const GatewayDetailPage(@PathParam('id') this.id, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      text: "Gateway details",
      child: GatewayDetailComponent(id),
    );
  }
}
