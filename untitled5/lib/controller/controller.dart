

import 'package:get/get.dart';
import 'package:untitled5/fetch_data/fecthData.dart';
import 'package:untitled5/localstorage/localstorage_helper.dart';
import 'package:untitled5/model/shoes_model.dart';

import '../model/cart_model.dart';

class Controller{

  RxList<ShoesModel> listShoes =RxList<ShoesModel>();
  RxList<CartModel> carts = RxList<CartModel>();
  RxDouble totalCarts = 0.0.obs;
  FetchData fetchData = FetchData();

  Future<void> setShoesListFromJson() async {
    listShoes.value = await fetchData.loadShoesFromJsonFile();
  }

  void addToCart (ShoesModel shoes){
    carts.add(
        CartModel(shoesModel: shoes, number: 1) 
    );
    totalCarts.value = carts.value.map((cart) => cart.number * cart.shoesModel.price).reduce((a, b) => a + b);
    LocalStorageHelper.saveInfoObject(carts);
  }
  void deleteShoes(CartModel cartModel){
    carts.removeWhere((cart) => cart == cartModel);
    totalCarts.value = totalCarts.value - (cartModel.number * cartModel.shoesModel.price);

  }
  void incrementNumber(CartModel cartModel){
    int i = 0;
    while (i<carts.length) {
      if (carts.value[i] == cartModel) {
        carts.value[i].number++;
        totalCarts.value= totalCarts.value + carts[i].shoesModel.price;
        break;
      }
      i++;
    }
  }
  void decrementNumber(CartModel cartModel){
    int i = 0;
    while (i<carts.length) {
      if (carts.value[i] == cartModel) {
        carts.value[i].number--;
        if(carts[i].number==0){
          totalCarts.value= totalCarts.value - carts[i].shoesModel.price;
          deleteShoes(carts[i]);
          break;
        }
        totalCarts.value= totalCarts.value - carts[i].shoesModel.price;
        break;
      }
      i++;
    }
  }
}