import 'dart:convert';

import 'package:barber_booking_app_clone/core/Data_models/map_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapDataProvider with ChangeNotifier {
  List<MapDataModel> mapDataList;

  MapDataProvider() {
    loadData();
  }

  loadData() async {
    final _mapjson =
        await rootBundle.loadString('lib/Temporary_data/map_data.json');
    final _parsed = json.decode(_mapjson).cast<Map<String, dynamic>>();
    mapDataList = _parsed
        .map<MapDataModel>((json) => MapDataModel.fromJson(json))
        .toList();

    notifyListeners();
    return true;
  }

  @override
  String toString() {
    // TODO: implement toString
    return mapDataList.toString();
  }

  get coordinates {
    List<dynamic> _coordinates;
    for (var i = 0; i < mapDataList.length; i++) {
      _coordinates.add(
          {"name": mapDataList[i].name, "location": mapDataList[i].location});
    }
    return [..._coordinates];
  }

  //Method will return the complete List of MapDataModel objects
  get completeData {
    return [...mapDataList];
  }

  MapDataModel singleComplete(String name) {
    return mapDataList.singleWhere((element) => element.name == name);
  }
}
