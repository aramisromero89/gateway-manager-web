import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/logic/auth_provider.dart';

import '../api/entities/user.dart';

final userProvider = FutureProvider<User?>((ref) async {
  final token = ref.watch(tokenProvider);
  if (token == null) {
    return null;
  }
  final res = await ref
      .read(requestHelperProvider)
      .request(ref.read(apiProvider).authDetail());
  if (res.data == null) {
    ref.read(authProvider).logout();
  }
  return res.data;
});
