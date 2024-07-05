import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/blog-model.dart';

class BlogController {
  var dio = getMainApiHandler();

  Future<List<BlogModel>?> blogDataService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        BLOG_ENDPOINT,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final List<dynamic> responseData = response.data['data']['articles'];

      List<BlogModel> blogs =
          responseData.map((data) => BlogModel.fromJson(data)).toList();

      return blogs;
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }

  Future<BlogModel?> blogDetailService(
      BuildContext context, String slug) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        "$BLOG_ENDPOINT/detail?slug=$slug",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData =
          response.data['data']['articles'];

      return BlogModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }
}
