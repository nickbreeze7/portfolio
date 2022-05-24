import 'dart:convert';

import 'package:barber_booking_app_clone/core/Data_models/barber_data_from_map/comment_model.dart';
import 'package:barber_booking_app_clone/core/Data_models/barber_data_from_map/service_model.dart';
import 'package:barber_booking_app_clone/core/Data_models/map_data_model.dart';
import 'package:flutter/material.dart';

class BarberDataFromMapModel {
  MapDataModel mapData;
  List<ServiceModel> services;
  List<dynamic> gallery;
  List<CommentModel> comments;

  BarberDataFromMapModel({
    @required this.mapData,
    @required this.services,
    @required this.gallery,
    @required this.comments,
  });

  /// Factory of converting raw JSON string to the BarberDataFromMapModel elements
  factory BarberDataFromMapModel.fromRawJson(String str) =>
      BarberDataFromMapModel.fromJson(json.decode(str));

  /// Method of converting Model into Raw JSON String
  String toRawJson() => json.encode(toJson());

  /// Factory for converting individual JSON object into BarberDataFromMapModel object
  factory BarberDataFromMapModel.fromJson(Map<String, dynamic> json) =>
      BarberDataFromMapModel(
        mapData: json["MapData"] == null
            ? null
            : MapDataModel.fromJson(json["MapData"]),
        services: json["Services"] == null
            ? null
            : List<ServiceModel>.from(
                json["Services"].map((x) => ServiceModel.fromJson(x))),
        gallery: json["Gallery"] == null
            ? null
            : List<dynamic>.from(json["Gallery"].map((x) => x)),
        comments: json["Comments"] == null
            ? null
            : List<CommentModel>.from(
                json["Comments"].map((x) => CommentModel.fromJson(x))),
      );

  /// Converting individual BarberDataFromMapModel object to a JSON object
  Map<String, dynamic> toJson() => {
        "MapData": mapData == null ? null : mapData.toJson(),
        "Services": services == null
            ? null
            : List<dynamic>.from(services.map((x) => x.toJson())),
        "Gallery":
            gallery == null ? null : List<dynamic>.from(gallery.map((x) => x)),
        "Comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
