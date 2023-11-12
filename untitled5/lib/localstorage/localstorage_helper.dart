import 'dart:convert';
import 'dart:html' as html;

import 'package:untitled5/configuration/config.dart';
import 'package:untitled5/model/cart_model.dart';
class LocalStorageHelper{

  static List<CartModel> getInfoObject() {
    final jsonString = html.window.localStorage[Configuration.KEY_INFO_CART];
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString) ;
      return jsonData.map((item) =>
          CartModel.fromJson(item)).toList();
    }
    return [];
  }

  static void saveInfoObject(List<CartModel> infoList) {
    final jsonString = jsonEncode(infoList.map((item) => item.toJson()).toList());
    html.window.localStorage[Configuration.KEY_INFO_CART] = jsonString;
  }


}