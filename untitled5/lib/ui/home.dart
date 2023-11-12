import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/controller/controller.dart';
import 'package:untitled5/model/cart_model.dart';
import 'package:untitled5/model/shoes_model.dart';
import 'package:intl/intl.dart';

import '../localstorage/localstorage_helper.dart';

///https://demo-baitest-flutter-8zv8.vercel.app/assets/assets/check.png
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller controller = Controller();

  //double height = 500;
  Color color_yellow = const Color(0xFFf6c90e);
  Color color_grey = Colors.grey;
  TextStyle textStyle = const TextStyle(
      fontFamily: 'Rubik,sans-serif',
      color: Colors.black87,
      fontSize: 24,
      fontWeight: FontWeight.w900);
  TextStyle textStyleTitleShoes = const TextStyle(
      fontFamily: 'Rubik,sans-serif',
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w700);
  TextStyle textStyleTitleCart = const TextStyle(
    fontFamily: 'Rubik,sans-serif',
    color: Colors.black87,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  TextStyle description = const TextStyle(
    fontFamily: 'Rubik,sans-serif',
    color: Colors.grey,
    height: 2,
    fontSize: 13,
  );
  double width = 370.0;
  double height = 650.0;
  NumberFormat format = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLocalStorage();
  }
  Future<void> getDataLocalStorage() async {
    try {
      controller.setShoesListFromJson();
      List<CartModel> carts =await LocalStorageHelper.getInfoObject();
      controller.carts.value = carts;

      for(CartModel a in carts){
        controller.totalCarts.value += a.number*a.shoesModel.price;
        for(int i=0;i<controller.listShoes.length;i++){
          if(controller.listShoes[i].id == a.shoesModel.id){
              print(controller.listShoes[i].id);
          }
        }
      }
    }catch(e){
      print(e);
    }
  }
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              Container(
                //padding: EdgeInsets.only(bottom: 50, top: 30),
                alignment: Alignment.center,
                child: (MediaQuery.of(context).size.width > 830)
                    ? SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cardView(0.0, 'Our Products', false),
                            cardView(
                                controller.totalCarts.value, 'Your Cart', true),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cardView(0.0, 'Our Products', false),
                            cardView(
                                controller.totalCarts.value, 'Your Cart', true),
                          ],
                        ),
                      ),
              ),
            ],
          )),
    );
  }

  Widget cardView(double totals, String title, bool isCart) {
    return Obx(() => Container(
          width: width,
          height: 620,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2), // Vị trí đổ shadow theo trục x và y
                blurRadius: 4, // Độ mờ của shadow
              ),
            ],
            color: Colors.white,
            //const Color(0xFFFFFFFF),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: [
                Positioned(
                  width: 300,
                  height: 300,
                  top: -300 / 2.5,
                  left: -300 / 1.7,
                  child: ClipRect(
                    child: Container(
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: color_yellow,
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/nike.png',
                        width: 50,
                        height: 50,
                      ),
                      (isCart == false)
                          ? Text(title, style: textStyle)
                          : Row(
                              children: [
                                Text(
                                  title,
                                  style: textStyle,
                                ),
                                const Spacer(),
                                Text(
                                  format.format(totals),
                                  style: textStyle,
                                )
                              ],
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      (isCart == false)
                          ? ((controller.listShoes.value.isNotEmpty)
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 500,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.listShoes.value.length,
                                    // Số lượng mục bạn muốn hiển thị
                                    itemBuilder: (context, index) {
                                      // return Container(child: Text('sanpham'),);
                                      ShoesModel a =
                                          controller.listShoes[index];
                                      Color color = Color(int.parse(
                                          a.color.replaceAll("#", "0xFF")));
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 100 * 3,
                                                height: 100 * 3.5,
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Transform.rotate(
                                                  angle: -20 *
                                                      3.1415926535897932 /
                                                      180,
                                                  // Chuyển đổi từ độ thành radian
                                                  child: Image.network(
                                                    a.image.toString(),
                                                  ),
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    a.name,
                                                    style: textStyleTitleShoes,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    textAlign:
                                                        TextAlign.justify,
                                                    a.description,
                                                    style: description,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        format.format(a.price),
                                                        style:
                                                            textStyleTitleShoes,
                                                      ),
                                                      const Spacer(),
                                                      (a.isSelected == false)
                                                          ? InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  controller
                                                                      .listShoes[
                                                                          index]
                                                                      .isSelected = true;
                                                                });
                                                                controller
                                                                    .addToCart(
                                                                        a);
                                                              },
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color:
                                                                          color_yellow),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: Text(
                                                                      'Add to cart',
                                                                      style:
                                                                          textStyleTitleShoes)),
                                                            )
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color:
                                                                    color_yellow,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child:
                                                                  Image.asset(
                                                                'assets/check.png',
                                                                width: 20,
                                                                height: 20,
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ))
                          : (controller.carts.value.isNotEmpty)
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  height: 500,
                                  child: ListView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.carts.length,
                                    // Số lượng mục bạn muốn hiển thị
                                    itemBuilder: (context, index) {
                                      // return Container(child: Text('sanpham'),);
                                      CartModel a = controller.carts[index];
                                      Color color = Color(int.parse(a
                                          .shoesModel.color
                                          .replaceAll("#", "0xFF")));
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 120,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Positioned(
                                                    left: 10,
                                                    top: (120 - 50) / 2,
                                                    child: Container(
                                                      width: 75,
                                                      height: 75,
                                                      decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                  ),
                                                  Transform.rotate(
                                                    angle: -20 *
                                                        3.1415926535897932 /
                                                        180,
                                                    // Chuyển đổi từ độ thành radian
                                                    child: Image.network(
                                                      a.shoesModel.image
                                                          .toString(),
                                                      width: 110,
                                                      height: 110,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 190,
                                                  child: Text(
                                                    a.shoesModel.name,
                                                    style: textStyleTitleCart,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    format.format(
                                                        a.shoesModel.price),
                                                    style: textStyleTitleShoes,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .incrementNumber(a);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: color_grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Image.asset(
                                                          'assets/plus.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          a.number.toString()),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (a.number == 1) {
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    controller
                                                                        .listShoes
                                                                        .length;
                                                                i++) {
                                                              if (controller
                                                                      .listShoes
                                                                      .value[i] ==
                                                                  a.shoesModel) {
                                                                setState(() {
                                                                  controller
                                                                      .listShoes
                                                                      .value[i]
                                                                      .isSelected = false;
                                                                });
                                                              }
                                                            }
                                                          });
                                                        }
                                                        controller
                                                            .decrementNumber(a);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: color_grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Image.asset(
                                                          'assets/minus.png',
                                                          width: 10,
                                                          height: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 80,
                                                    ),
                                                    // Spacer(),
                                                    InkWell(
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: color_yellow,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Image.asset(
                                                            'assets/trash.png',
                                                            width: 20,
                                                            height: 20,
                                                          )),
                                                      onTap: () {
                                                        setState(() {
                                                          for (int i = 0;
                                                              i <
                                                                  controller
                                                                      .listShoes
                                                                      .length;
                                                              i++) {
                                                            if (controller
                                                                    .listShoes
                                                                    .value[i] ==
                                                                a.shoesModel) {
                                                              setState(() {
                                                                controller
                                                                    .listShoes
                                                                    .value[i]
                                                                    .isSelected = false;
                                                              });
                                                            }
                                                          }
                                                        });

                                                        controller
                                                            .deleteShoes(a);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  child: const Text(
                                    'Không có dữ liệu',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
