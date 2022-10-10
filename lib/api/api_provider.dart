import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gateway_manager_client/api/api_client.dart';

const baseUrl =
    String.fromEnvironment("baseApiUrl", defaultValue: "http://localhost:3000");

final apiProvider = Provider<ApiClient>((_) {
  return ApiClient(Dio(), baseUrl: baseUrl);
});

final requestHelperProvider =
    Provider<RequestHelper>((ref) => RequestHelper(ref));

class RequestHelper {
  Ref ref;
  RequestHelper(this.ref);
  Future<ApiResponse<T>> request<T>(Future<T> operation) async {
    try {
      final res = await operation;
      return ApiResponse(data: res);
    } catch (e) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Something wrong happened",
        timeInSecForIosWeb: 4,
      );
      return ApiResponse(error: e);
    }
  }
}
