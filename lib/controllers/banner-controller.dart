import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/banner-model.dart';

class BannerController {
  var dio = getMainApiHandler();

  Future<List<BannerModel>?> bannerDataService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        BANNER_ENDPOINT,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final List<dynamic> responseData = response.data['data']['data'];

      List<BannerModel> banners =
          responseData.map((data) => BannerModel.fromJson(data)).toList();

      return banners;
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }

  Future<BannerModel?> bannerDetailService(
      BuildContext context, String slug) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        "$BANNER_ENDPOINT/$slug",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData = response.data['data'];

      return BannerModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }
}
