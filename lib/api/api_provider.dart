import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gateway_manager_client/api/api_client.dart';
import 'package:gateway_manager_client/logic/auth_provider.dart';
import 'package:gateway_manager_client/logic/shared_preferences_provider.dart';

import '../util/toast_helper.dart';

const baseUrl =
    String.fromEnvironment("baseApiUrl", defaultValue: "http://localhost:3000");

final apiProvider = Provider<ApiClient>((ref) {
  final token = ref.watch(tokenProvider);

  return ApiClient(
      Dio(BaseOptions(headers: {
        "Authorization": token ?? "",
      })),
      baseUrl: baseUrl);
});

final requestHelperProvider =
    Provider<RequestHelper>((ref) => RequestHelper(ref));

class RequestHelper {
  Ref ref;
  RequestHelper(this.ref);
  Future<ApiResponse<T>> request<T>(Future<T> operation) async {
    EasyLoading.show(status: 'loading...');
    try {
      final res = await operation;
      EasyLoading.dismiss();
      return ApiResponse(data: res);
    } catch (e) {
      showToast("Something wrong happened");
      return ApiResponse(error: e);
    }
  }
}
