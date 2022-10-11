import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/entities/device.dart';
import 'package:gateway_manager_client/api/enum/device_status.dart';
import 'package:gateway_manager_client/api/params/common/id_int.dart';
import 'package:gateway_manager_client/api/params/device/device_create.dart';
import 'package:gateway_manager_client/api/params/device/device_edit.dart';

import '../util/custom_validators.dart';

class DeviceEditForm extends ConsumerStatefulWidget {
  final int? id;
  final String? gatewayId;
  const DeviceEditForm({
    this.id,
    this.gatewayId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceEditFormState();
}

class _DeviceEditFormState extends ConsumerState<DeviceEditForm> {
  late Future<Device?> _future;
  final _controller = TextEditingController();
  bool _online = false;
  bool _sending = false;
  final _fkey = GlobalKey<FormState>();

  Future<Device?> _buildFuture() async {
    if (widget.id == null) {
      return Future.value();
    }
    final res = await ref
        .read(requestHelperProvider)
        .request(ref.read(apiProvider).deviceDetail(IdInt(id: widget.id!)));

    setState(() {
      if (res.data != null) {
        _online = res.data!.status == DeviceStatus.online;
        _controller.text = res.data!.vendor;
      }
    });
    return res.data;
  }

  @override
  void initState() {
    _future = _buildFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<Device?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: _fkey,
              child: Column(
                children: [
                  Text(widget.id == null ? "Create device" : "Edit device"),
                  TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(label: Text("Vendor")),
                    validator: emptyValidator,
                  ),
                  Row(
                    children: [
                      Text(_online ? "online" : "offline"),
                      Switch(
                        value: _online,
                        onChanged: (online) {
                          setState(() {
                            _online = online;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _sending
                        ? null
                        : (() async {
                            setState(() {
                              _sending = true;
                            });
                            if (_fkey.currentState!.validate()) {
                              var request = widget.id == null
                                  ? ref.read(apiProvider).deviceCreate(
                                        DeviceCreate(
                                          vendor: _controller.text,
                                          status: _online
                                              ? DeviceStatus.online
                                              : DeviceStatus.offline,
                                          gatewaySerialNumber:
                                              widget.gatewayId!,
                                        ),
                                      )
                                  : ref.read(apiProvider).deviceEdit(
                                        DeviceEdit(
                                            id: widget.id!,
                                            vendor: _controller.text,
                                            status: _online
                                                ? DeviceStatus.online
                                                : DeviceStatus.offline,
                                            gatewaySerialNumber: snapshot
                                                .data!.gatewaySerialNumber),
                                      );
                              final res = await ref
                                  .read(requestHelperProvider)
                                  .request(request);
                              if (res.data != null) {
                                context.router.pop(true);
                              }
                            }
                            setState(() {
                              _sending = false;
                            });
                          }),
                    child: Text(widget.id == null ? "Create" : "Update"),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
