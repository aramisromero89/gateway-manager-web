import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_list.dart';

const pageSize = 5;

final currentPageProvider = StateProvider<int>((ref) {
  return 1;
});

final totalItemsProvider = StateProvider<int>((ref) {
  return 0;
});

final totalPagesProvider = StateProvider<int>((ref) {
  final totalItems = ref.watch(totalItemsProvider);

  return (totalItems / pageSize).ceil();
});

final itemsProvider = FutureProvider(((ref) async {
  final currentPage = ref.watch(currentPageProvider);
  final res = await ref
      .read(apiProvider)
      .gatewayList(GatewayList(count: pageSize, page: currentPage));
  ref.read(totalItemsProvider.notifier).state = res.total;

  final totalPages = ref.read(totalPagesProvider);
  if (currentPage > totalPages) {
    if (totalPages > 0) {
      ref.read(currentPageProvider.notifier).state = totalPages;
    } else {
      ref.read(currentPageProvider.notifier).state = 1;
    }
  }
  return res;
}));
