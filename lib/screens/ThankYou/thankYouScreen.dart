import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key key}) : super(key: key);

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  final cro = Get.find<CartData>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Text("Confirmation", style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          // color: Colors.amber,
          width: double.infinity,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(tx),
                      // LottieBuilder.network(
                      //   "https://assets6.lottiefiles.com/datafiles/8UjWgBkqvEF5jNoFcXV4sdJ6PXpS6DwF7cK4tzpi/Check Mark Success/Check Mark Success Data.json",
                      //   repeat: false,
                      //   height: 350.0,
                      // ),
                      LottieBuilder.asset(
                        checkmark,
                        height: 350.0,
                        repeat: false,
                      ),
                      Text(
                        "Order Placed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Thank you! your order has been placed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "successfully",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                LottieBuilder.asset(
                  samplecong,
                  reverse: false,
                  repeat: false,
                ),
                Positioned(
                  bottom: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          minimumSize: Size(356, 50)),
                      onPressed: () {
                        print("home");
                        Hive.box(TestBox).clear();
                        cro.cartitme1();
                        
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                            (route) => false);
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Continue Shopping"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
