import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/entities/device.dart';
import 'package:gateway_manager_client/api/entities/gateway.dart';
import 'package:gateway_manager_client/api/enum/device_status.dart';
import 'package:gateway_manager_client/api/params/common/id_int.dart';
import 'package:gateway_manager_client/api/params/common/id_string.dart';
import 'package:gateway_manager_client/api/params/device/device_create.dart';
import 'package:gateway_manager_client/api/params/device/device_edit.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_create.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_edit.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../util/custom_validators.dart';

class GatewayEditForm extends ConsumerStatefulWidget {
  final String? id;
  const GatewayEditForm({
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GatewayEditFormState();
}

class _GatewayEditFormState extends ConsumerState<GatewayEditForm> {
  late Future<Gateway?> _future;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  bool _sending = false;
  final _fkey = GlobalKey<FormState>();

  Future<Gateway?> _buildFuture() async {
    if (widget.id == null) {
      return Future.value();
    }
    final res = await ref
        .read(requestHelperProvider)
        .request(ref.read(apiProvider).gatewayDetail(IdString(id: widget.id!)));

    setState(() {
      if (res.data != null) {
        _nameController.text = res.data!.name;
        _addressController.text = res.data!.address;
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
      child: FutureBuilder<Gateway?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: _fkey,
              child: Column(
                children: [
                  Text(widget.id == null ? "Create gateway" : "Edit device"),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(label: Text("Name")),
                    validator: emptyValidator,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(label: Text("Address")),
                    validator: (text) {
                      if (text == null || text.isEmpty || !validator.ip(text)) {
                        return "Must be a valid IP";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sending
                        ? null
                        : (() async {
                            setState(() {
                              _sending = true;
                            });
                            if (_fkey.currentState!.validate()) {
                              var request = widget.id == null
                                  ? ref.read(apiProvider).gatewayCreate(
                                        GatewayCreate(
                                            name: _nameController.text,
                                            address: _addressController.text),
                                      )
                                  : ref.read(apiProvider).gatewayEdit(
                                        GatewayEdit(
                                            serialNumber: widget.id!,
                                            name: _nameController.text,
                                            address: _addressController.text),
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
