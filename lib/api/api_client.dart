import 'package:dio/dio.dart';
import 'package:gateway_manager_client/api/entities/gateway.dart';
import 'package:gateway_manager_client/api/entities/gateway_list_data.dart';
import 'package:gateway_manager_client/api/params/common/id_int.dart';
import 'package:gateway_manager_client/api/params/common/id_string.dart';
import 'package:gateway_manager_client/api/params/device/device_create.dart';
import 'package:gateway_manager_client/api/params/device/device_edit.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_create.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_edit.dart';
import 'package:gateway_manager_client/api/params/gateway/gateway_list.dart';
import 'package:retrofit/retrofit.dart';

import 'entities/device.dart';
part "api_client.g.dart";

class ApiResponse<T> {
  T? data;
  dynamic error;
  ApiResponse({this.data, this.error});
}

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/device/list")
  Future<List<Device>> devicesByGateway(@Body() IdString gatewayId);

  @POST("/device/create")
  Future<Device> deviceCreate(@Body() DeviceCreate args);

  @POST("/device/edit")
  Future<Device> deviceEdit(@Body() DeviceEdit args);

  @POST("/device/detail")
  Future<Device> deviceDetail(@Body() IdInt args);

  @POST("/device/remove")
  Future<Device> deviceRemove(@Body() IdInt id);

  @POST("/gateway/list")
  Future<GatewayListData> gatewayList(@Body() GatewayList args);

  @POST("/gateway/create")
  Future<Gateway> gatewayCreate(@Body() GatewayCreate args);

  @POST("/gateway/edit")
  Future<Gateway> gatewayEdit(@Body() GatewayEdit args);

  @POST("/gateway/detail")
  Future<Gateway> gatewayDetail(@Body() IdString id);

  @POST("/gateway/remove")
  Future<Gateway> gatewayRemove(@Body() IdString id);
}
