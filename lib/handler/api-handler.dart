import 'package:dio/dio.dart';

import '../contants/attribute.dart';
import '../contants/constant.dart';

Dio getMainApiHandler() {
  return Dio(
    BaseOptions(
      baseUrl: MAIN_BASE_URL,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
    ),
  );
}

Dio getBaseApiHandler() {
  return Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
    ),
  );
}
