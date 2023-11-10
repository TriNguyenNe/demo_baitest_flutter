// import 'package:flutter/material.dart';
// import 'package:untitled5/model/cart_model.dart';
//
// class CartWidget extends StatelessWidget {
//   final CartModel item;
//   final Animation animation;
//   final VoidCallback onClicked;
//   CartWidget({required this.item, required this.animation, required this.onClicked, Key key,}):super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//         scale:animation,
//         child:Row(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                   left: 10,
//                   top: (120 - 40) / 2,
//                   child: Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       color: color,
//                       borderRadius:
//                       BorderRadius.circular(100),
//                     ),
//                   ),
//                 ),
//                 Transform.rotate(
//                   angle: -15 * 3.1415926535897932 / 180,
//                   // Chuyển đổi từ độ thành radian
//                   child: Image.network(
//                     item.shoesModel.image.toString(),
//                     width: 120,
//                     height: 120,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Text(item.shoesModel.name),
//                 Text(item.shoesModel.price.toString()),
//                 Row(
//                   children: [
//                     Text(a.number.toString()),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),);
//   }
// }
