import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woocommerce_app/config.dart';
import 'package:woocommerce_app/models/customer.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.consumer_key + ":" + Config.consumer_secret),
    );

    bool ret = false;

    try {
      var response = await Dio().post(
        Config.url + Config.customersURL,
        data: model.toJson(),
        options: new Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
        ret = false;
      } else {
        print(e.message);
        print(e.request);
        ret = false;
      }
    }

    return ret;
  }
}
