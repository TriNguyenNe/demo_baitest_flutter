import 'package:untitled5/model/shoes_model.dart';

class CartModel{
  ShoesModel shoesModel;
  int number;

  CartModel({required this.shoesModel, required this.number});

  factory CartModel.fromJson(Map<String, dynamic> json){
    return CartModel(
        shoesModel: ShoesModel.fromJson(json['shoesModel']),
        number: (json['number'] !=null)? json['number']:0);
  }

  Map<String,dynamic> toJson(){
    return {
      'shoesModel': shoesModel.toJson(),
      'number':number,
    };
  }
}