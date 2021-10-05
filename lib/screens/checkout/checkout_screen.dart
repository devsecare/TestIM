// import 'package:chrisandsons/screens/ThankYou/thankYouScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// // import 'package:woocommerce/woocommerce.dart';

// class CheckOutScreen extends StatefulWidget {
//   final String data;

//   const CheckOutScreen({
//     Key key,
//     this.data,
//   }) : super(key: key);
//   @override
//   _CheckOutScreenState createState() => _CheckOutScreenState();
// }

// class _CheckOutScreenState extends State<CheckOutScreen> {
//   final _formKey = GlobalKey<FormState>();
//   // static const platform = const MethodChannel("razorpay_flutter");

//   FocusNode textFocusController = FocusNode();

//   String fname, lname, ad, pno, city;

//   Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckOut() async {
//     var price = int.parse(widget.data.toString());
//     var options = {
//       'key': 'rzp_test_FgLj2GruP8JI09',
//       'amount': widget.data * 100, //in the smallest currency sub-unit.
//       'name': 'Incredible Man.',
//       // 'order_id': 'newtest', // Generate order_id using Orders API
//       // 'description': ,
//       // 'timeout': 60, // in seconds
//       'prefill': {
//         'contact': '9123456789',
//         'email': 'jayveersinh.ecare@gmail.com'
//       },
//       'external': {
//         'wallets': ['paytm', 'gpay']
//       }
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("aa razor ni error che $e");
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment Success : ${response.paymentId}",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//     Get.to(() => ThankYouScreen());
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment Error ${response.message}",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment Wallet : ${response.walletName}",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Check Out ",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Container(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.person),
//                     hintText: 'Enter your full name',
//                     labelText: ' firstName',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     fname = newValue;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.person),
//                     hintText: 'Enter your lastName',
//                     labelText: ' lastName',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     lname = newValue;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.person),
//                     hintText: 'Address1',
//                     labelText: ' Address1',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     ad = newValue;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.person),
//                     hintText: 'City',
//                     labelText: ' City',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     city = newValue;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.person),
//                     hintText: 'Mobile no',
//                     labelText: 'Mobile no',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     pno = newValue;
//                   },
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () async {
//                     openCheckOut();
//                     // if (_formKey.currentState.validate()) {
//                     //   _formKey.currentState.save();
//                     //   int subtotal = int.parse(widget.data.price) * 2;
//                     //   // WooOrderPayload orderPayload = WooOrderPayload(
//                     //   //   customerId: 19,
//                     //   //   paymentMethod: "Direct Bank Transfer",
//                     //   //   setPaid: false,
//                     //   //   currency: "IND",
//                     //   //   billing: WooOrderPayloadBilling(
//                     //   //     address1: ad,
//                     //   //     firstName: fname,
//                     //   //     lastName: lname,
//                     //   //     city: city,
//                     //   //   ),
//                     //   //   shipping: WooOrderPayloadShipping(
//                     //   //     address1: ad,
//                     //   //     firstName: fname,
//                     //   //     lastName: lname,
//                     //   //     city: city,
//                     //   //   ),
//                     //   //   lineItems: [
//                     //   //     LineItems(
//                     //   //       productId: widget.data.id,
//                     //   //       total: subtotal.toString(),
//                     //   //       quantity: 2,
//                     //   //       subtotal: subtotal.toString(),
//                     //   //     )
//                     //   //   ],
//                     //   //   metaData: [],
//                     //   //   couponLines: [],
//                     //   // );

//                     //   // WooOrder order =
//                     //   //     await CartData.woocommerce.createOrder(orderPayload);
//                     //   // print("order aa che :" + order.id.toString());
//                     //   // print(orderPayload);
//                     //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     //   //   content: const Text(" Order has been placed "),
//                     //   // ));
//                     //   // Navigator.pop(context);
//                     // }
//                   },
//                   icon: Icon(
//                     Icons.done,
//                   ),
//                   label: const Text("Submit"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
