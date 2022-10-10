import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/params/common/id_int.dart';
import 'package:gateway_manager_client/components/device_edit_form.dart';
import 'package:gateway_manager_client/router/router.gr.dart';
import 'package:intl/intl.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/entities/device.dart';
import 'package:gateway_manager_client/api/params/common/id_string.dart';

class DeviceListComponent extends ConsumerStatefulWidget {
  final String gatewayId;
  const DeviceListComponent(this.gatewayId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceListComponentState();
}

class _DeviceListComponentState extends ConsumerState<DeviceListComponent> {
  late Future<List<Device>> _future;

  Future<List<Device>> _buildFuture() async {
    final res = await ref.read(requestHelperProvider).request(
        ref.read(apiProvider).devicesByGateway(IdString(id: widget.gatewayId)));
    return res.data ?? [];
  }

  @override
  void initState() {
    _future = _buildFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: (() async {
              final res = await showModalBottomSheet<bool?>(
                context: context,
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 300),
                builder: (context) => Center(
                  child: DeviceEditForm(gatewayId: widget.gatewayId),
                ),
              );
              if (res == true) {
                setState(() {
                  _future = _buildFuture();
                });
              }
            }),
            child: const Text("Add device")),
        FutureBuilder<List<Device>>(
          future: _future,
          builder: (context, snapshot) {
            List<DataRow> rows = [];
            if (snapshot.hasData) {
              rows = snapshot.data!
                  .map((e) => DataRow(cells: [
                        DataCell(Text(e.vendor)),
                        DataCell(Text(e.status.name)),
                        DataCell(Text(DateFormat.yMd().format(e.date))),
                        DataCell(Row(
                          children: [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () async {
                                  final res = await showModalBottomSheet<bool?>(
                                    context: context,
                                    constraints: const BoxConstraints(
                                        maxHeight: 200, maxWidth: 300),
                                    builder: (context) => Center(
                                      child: DeviceEditForm(id: e.id),
                                    ),
                                  );
                                  if (res == true) {
                                    setState(() {
                                      _future = _buildFuture();
                                    });
                                  }
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () async {
                                  final res = await ref
                                      .read(requestHelperProvider)
                                      .request(ref
                                          .read(apiProvider)
                                          .deviceRemove(IdInt(id: e.id)));
                                  if (res.data != null) {
                                    setState(() {
                                      _future = _buildFuture();
                                    });
                                  }
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )),
                      ]))
                  .toList();
            }

            return DataTable(columns: const [
              DataColumn(label: Text("Vendor")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Actions"))
            ], rows: rows);
          },
        )
      ],
    );
  }
}
