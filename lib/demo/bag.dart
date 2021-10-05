import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/order.dart';

class BagScreen extends StatelessWidget {
  final List<WooOrder> orders;
  const BagScreen({Key key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(orders.length ?? "nthi");

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: orders.isEmpty
          ? Container(
              child: Center(
                child: Text("No Orders Yet"),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "My Orders",
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final ord = orders[index];
                            final name = ord.lineItems[0].name;
                            // print(orders[0]);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _orderList(
                                ord,
                                name,
                                () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) =>
                                  //             OrderTimelineScreen()));
                                },
                                height,
                                width,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black45,
                          ),
                          itemCount: orders.length,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _orderList(
    WooOrder order,
    String name,
    VoidCallback timeline,
    var height,
    var width,
  ) {
    return GestureDetector(
      onTap: timeline,
      child: Container(
        width: width,
        child: Row(
          children: [
            Container(
              height: height / 8,
              width: width / 4,
              decoration: BoxDecoration(
                color: bgcontainer,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                logoloader,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 9.0,
            ),
            Container(
              // color: Colors.red,
              width: width / 1.99,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.status,
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                  Text(
                    rupee + order.total,
                    style: GoogleFonts.poppins(
                      color: Colors.black38,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     CupertinoIcons.forward,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
