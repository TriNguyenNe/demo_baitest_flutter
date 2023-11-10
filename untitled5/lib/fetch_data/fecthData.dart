import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

import '../model/shoes_model.dart';

class FetchData {

  Future<List<ShoesModel>> loadShoesFromJsonFile() async {
    try {
      final jsondata = await rootBundle.rootBundle.loadString(
          'data/shoes.json');
      final Map<String, dynamic> data = json.decode(jsondata);
      final List<dynamic> shoeList = data['shoes'];

      return shoeList.map((e) => ShoesModel.fromJson(e)).toList();
    } catch (e) {
      print('Error loading JSON data: $e');
      return [];
    }
  }
}
