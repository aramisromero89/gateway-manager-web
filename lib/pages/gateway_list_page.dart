import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/params/common/id_string.dart';
import 'package:gateway_manager_client/components/custom_scaffold.dart';
import 'package:gateway_manager_client/logic/gateway_list_provider.dart';
import 'package:gateway_manager_client/components/gateway_edit_form.dart';
import 'package:gateway_manager_client/router/router.gr.dart';

class GatewayListPage extends ConsumerWidget {
  const GatewayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPages = ref.watch(totalPagesProvider);
    final currentPage = ref.watch(currentPageProvider);
    final pageSize = ref.watch(pageSizeProvider);
    final items = ref.watch(itemsProvider);
    return CustomScaffold(
      text: "Gateway list",
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (items.isLoading) const LinearProgressIndicator(),
            ElevatedButton(
              onPressed: (() async {
                final res = await showModalBottomSheet<bool?>(
                  context: context,
                  constraints:
                      const BoxConstraints(maxHeight: 250, maxWidth: 300),
                  builder: (context) => const Center(
                    child: GatewayEditForm(),
                  ),
                );
                if (res == true) {
                  ref.refresh(itemsProvider);
                }
              }),
              child: const Text("Add gateway"),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Address")),
                DataColumn(label: Text("Device Count")),
                DataColumn(label: Text("Actions"))
              ],
              rows: [
                if (items.value != null)
                  ...items.value!
                      .map((e) => DataRow(
                            cells: [
                              DataCell(Text(e.name)),
                              DataCell(Text(e.address)),
                              DataCell(Text(e.devicesCount.toString())),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      splashRadius: 20,
                                      onPressed: () {
                                        context.router.push(GatewayDetailRoute(
                                            id: e.serialNumber));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      splashRadius: 20,
                                      onPressed: () async {
                                        final res = await ref
                                            .read(requestHelperProvider)
                                            .request(ref
                                                .read(apiProvider)
                                                .gatewayRemove(IdString(
                                                    id: e.serialNumber)));
                                        if (res.data != null) {
                                          ref.refresh(itemsProvider);
                                        }
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              )),
                            ],
                          ))
                      .toList()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: currentPage > 1
                      ? () {
                          ref.read(currentPageProvider.notifier).state--;
                        }
                      : null,
                  child: const Icon(Icons.arrow_left),
                ),
                Text("$currentPage/${totalPages > 0 ? totalPages : 1}"),
                TextButton(
                  onPressed: currentPage < totalPages
                      ? () {
                          ref.read(currentPageProvider.notifier).state++;
                        }
                      : null,
                  child: const Icon(Icons.arrow_right),
                ),
                const Text("Page size"),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<int>(
                  value: pageSize,
                  items: [5, 2, 10]
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList(),
                  onChanged: (size) =>
                      ref.read(pageSizeProvider.notifier).state = size!,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
