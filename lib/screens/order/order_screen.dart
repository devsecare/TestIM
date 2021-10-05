// import 'package:flutter/material.dart';
// import 'package:woocommerce/models/order.dart';

// class OrderScreen extends StatefulWidget {
//   final List<WooOrder> orders;

//   const OrderScreen({Key key, this.orders}) : super(key: key);
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.orders.length ?? "nthi");
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 70.0,
//           title: Text(
//             "My Orders",
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//         body: widget.orders.isEmpty
//             ? Container(
//                 child: Center(
//                   child: Text("No Orders Yet"),
//                 ),
//               )
//             : ListView.builder(
//                 itemBuilder: (context, index) {
//                   final ord = widget.orders[index];
//                   final name = ord.lineItems[0].name;
//                   return ListTile(
//                     title: Text(name),
//                     subtitle: Text(ord.status),
//                     trailing: Text(ord.total),
//                   );
//                 },
//                 itemCount: widget.orders.length,
//               ));
//   }
// }
