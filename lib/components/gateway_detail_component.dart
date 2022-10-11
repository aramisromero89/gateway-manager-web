import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/entities/gateway.dart';
import 'package:gateway_manager_client/components/custom_scaffold.dart';
import 'package:gateway_manager_client/components/device_list_component.dart';
import 'package:gateway_manager_client/components/gateway_edit_form.dart';
import 'package:gateway_manager_client/router/router.gr.dart';

import '../api/params/common/id_string.dart';
import 'gateway_edit_form.dart';

class GatewayDetailComponent extends ConsumerStatefulWidget {
  final String id;
  const GatewayDetailComponent(@PathParam('id') this.id, {Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GatewayDetailComponentState();
}

class _GatewayDetailComponentState
    extends ConsumerState<GatewayDetailComponent> {
  late Future<Gateway?> _future;

  Future<Gateway?> _buildFuture() async {
    final res = await ref
        .read(requestHelperProvider)
        .request(ref.read(apiProvider).gatewayDetail(IdString(id: widget.id)));
    return res.data;
  }

  @override
  void initState() {
    _future = _buildFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<Gateway?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final res = await showModalBottomSheet<bool?>(
                              context: context,
                              constraints: const BoxConstraints(
                                  maxHeight: 250, maxWidth: 300),
                              builder: (context) => Center(
                                child: GatewayEditForm(id: widget.id),
                              ),
                            );
                            if (res == true) {
                              setState(() {
                                _future = _buildFuture();
                              });
                            }
                          },
                          child: const Text("Update gateway data")),
                      TextButton(
                        onPressed: () {
                          context.router.replaceAll([const GatewayListRoute()]);
                        },
                        child: const Text("Back to gateway list"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(snapshot.data!.name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Address: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(snapshot.data!.address),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DeviceListComponent(widget.id),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
