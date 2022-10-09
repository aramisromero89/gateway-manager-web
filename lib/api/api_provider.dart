import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/api/api_client.dart';

final apiProvider = Provider<ApiClient>(
    (_) => ApiClient(Dio(), baseUrl: "http://localhost:3000"));
