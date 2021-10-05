import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:chrisandsons/provider/carttestModel/cartbox.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/ThankYou/thankYouScreen.dart';
import 'package:chrisandsons/widget/shimmerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/order_payload.dart';

class SummaryScreen extends StatefulWidget {
  final WooCustomer user;
  final String price;
  final List<CartBox> products;
  const SummaryScreen({Key key, this.user, this.price, this.products})
      : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final cro = Get.find<CartData>();
  Razorpay _razorpay;
  List<LineItems> lineItems;
  bool _loading;
  TextEditingController _coupon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var shipping = "FREE";
  var shipvalue = 0;
  var finalprice;
  var gstvalue;
  var couponvalue = 0.0;
  var gstadd;
  var cgst;
  var sgst;
  var igst = 18;
  bool guj = false;

  String shippingTitle;
  String shippingid;
  @override
  void initState() {
    _loading = true;
    super.initState();
    print("aa id product in ${widget.products[0].id}");
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getAddre();

    // lineItem();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  getAddre() async {
    print("aa first ${widget.price}");
    if (widget.user.billing.state == "GUJARAT" ||
        widget.user.billing.state == "GUJRAT" ||
        widget.user.billing.state == "Gujarat" ||
        widget.user.billing.state == "gujarat" ||
        widget.user.billing.state == "GJ" ||
        widget.user.billing.state == "gj") {
      cgst = (double.parse(widget.price) * 9) / 100;
      sgst = (double.parse(widget.price) * 9) / 100;
      guj = true;
      print("AA Gujarat Vado Che");
    }
    gstadd = (double.parse(widget.price) * igst) / 100;
    gstvalue = (double.parse(widget.price) + gstadd).roundToDouble();
    print("aa gst value che $gstvalue");

    //  var addre = await CartData.woocommerce
    //         .getAllShippingZoneMethods(shippingZoneId: 1);
    // print(addre);

    try {
      var ch = await CartData.shippingDatat();

      var com = double.parse(ch[1].settings.minAmount.value ?? 1000.0);
      print("aa check thse $com");
      if (double.parse(widget.price) < com) {
        print("aa biju ${widget.price}");

        print(ch[0].settings.cost.value);
        setState(() {
          shipvalue = int.parse(ch[0].settings.cost.value);
          shippingid = ch[0].methodId;
          shippingTitle = ch[0].methodTitle;

          finalprice = gstvalue + shipvalue;
          print("aa final value che $finalprice");
          _loading = false;
        });
      } else {
        print("aa triju ${widget.price}");
        setState(() {
          shippingid = ch[1].methodId;
          shippingTitle = ch[1].methodTitle;
          finalprice = gstvalue;
          _loading = false;
        });
      }
    } catch (e) {
      Get.defaultDialog(
          title: "Ooops...",
          content: Text("Somthing went wrong please try again"));
    }
  }

  couponcheck({String code}) async {
    setState(() {
      _loading = true;
    });
    try {
      var cop = await CartData.couponCheck(code: code);
      if (cop.length == 0) {
        print("naaa paade che coupon");
        setState(() {
          _loading = false;
        });
        Get.snackbar(
          "Invalid Coupon",
          "This Coupon is Invalid ",
          backgroundColor: Colors.white,
        );
      } else {
        setState(() {
          couponvalue = double.parse(cop[0].amount);
          finalprice = finalprice - couponvalue;
          _loading = false;
          print(finalprice);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void openCheckOut() async {
    var price = double.parse(finalprice.toString());

    var options = {
      'key': "rzp_test_teKzXCFq3aq5Ro",
      'amount': price * 100, //in the smallest currency sub-unit.
      'name': 'Incredible Man',
      // 'order_id': 'newtest', // Generate order_id using Orders API
      // 'description': ,
      // 'timeout': 60, // in seconds
      'prefill': {
        'contact': widget.user.billing.phone,
        'email': widget.user.billing.email
      },
      'external': {
        'wallets': ['paytm', 'gpay']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("aa razor ni error che $e");
    }
  }

  void orderDone(String id) async {
    WooOrderPayload orderPayload = WooOrderPayload(
      customerId: widget.user.id,
      paymentMethod: "razorpay",
      setPaid: true,
      metaData: [
        WooOrderPayloadMetaData(
          key: "_transaction_id",
          value: id,
        ),
       
        
      ],
      lineItems: widget.products
          .map(
            (e) => LineItems(
              productId: e.id,
              quantity: e.quntity,
              name: e.name,
            ),
          )
          .toList(),
      billing: WooOrderPayloadBilling(
        address1: widget.user.billing.address1,
        address2: widget.user.billing.address2,
        firstName: widget.user.firstName,
        city: widget.user.billing.city,
        postcode: widget.user.billing.postcode,
        state: widget.user.billing.state,
        phone: widget.user.billing.phone,
        email: widget.user.billing.email,
      ),
      shipping: WooOrderPayloadShipping(
        address1: widget.user.billing.address1,
        address2: widget.user.billing.address2,
        firstName: widget.user.firstName,
        city: widget.user.billing.city,
        postcode: widget.user.billing.postcode,
        state: widget.user.billing.state,
      ),
      shippingLines: [
        ShippingLines(
          methodId: shippingid,
          methodTitle: shippingTitle,
          total: shipvalue.toString(),
        ),
      ],
      couponLines: [],
    );

    var od = await CartData.woocommerce.createOrder(orderPayload);
    print(od.total);
    for (var i = 0; i < od.taxLines.length; i++) {
      print(od.taxLines[i].label);
    }

    Hive.box(TestBox).clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //   msg: "Payment Success : ${response.paymentId}",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    // );
    orderDone(response.paymentId);

    Get.offAll(() => ThankYouScreen());
    Get.snackbar(
      "Payment",
      "Payment Success:",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Payment failed",
      "Payment Error: something went wrong please try again",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    // Fluttertoast.showToast(
    //   msg: "Payment Error ${response.message}",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    // );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "walletName",
      "Payment wallet: ${response.walletName}",
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
    // Fluttertoast.showToast(
    //   msg: "Payment Wallet : ${response.walletName}",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    // );
  }

  //
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shopping details"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 80.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 0.8,
                  color: Colors.black54,
                ),
              )),
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Total:",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: tabColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _loading
                          ? PriceLoading()
                          : finalprice == 0
                              ? Text(
                                  "$rupee ${widget.price}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  "$rupee $finalprice",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                    ],
                  ),
                ),
                _loading
                    ? PriceLoading()
                    : ElevatedButton(
                        onPressed: () {
                          openCheckOut();
                          
                        },
                        child: Text(
                          "PAY NOW",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.8, 60)),
                      ),
              ],
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "PRICE DETAILS",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        // PriceLoading(),
                        Text(
                          "(${widget.products.length}  ITEMS)",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 35,
                    thickness: 0.8,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total MRP",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _loading
                                ? PriceLoading()
                                : Text(
                                    "$rupee ${widget.price}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        guj
                            ? Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "CGST",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        _loading
                                            ? PriceLoading()
                                            : Text(
                                                "+ $rupee$cgst",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "SGST",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        _loading
                                            ? PriceLoading()
                                            : Text(
                                                "+ $rupee$sgst",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _loading
                                          ? PriceLoading()
                                          : Text(
                                              "IGST",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                      _loading
                                          ? PriceLoading()
                                          : Text(
                                              "+ $rupee$gstadd",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        _loading
                            ? PriceLoading()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  shipvalue == 0
                                      ? Text(
                                          "Shipping FEE",

                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          "Shipping Rate",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  shipvalue == 0
                                      ? Text(
                                          "FREE",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          "+ $rupee ${shipvalue.toString()}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                  couponvalue == 0.0
                      ? Container(
                          child: Form(
                            key: _formkey,
                            child: TextFormField(
                              controller: _coupon,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "No Coupon";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formkey.currentState.validate()) {
                                        couponcheck(code: _coupon.text);
                                      }
                                    },
                                    child: Text("Check",
                                        style: GoogleFonts.poppins(
                                          color: tabColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Coupon Code',
                                hintText: 'Enter secure password',
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Coupon Discount",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "- $rupee ${couponvalue.toString()}",
                                style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Divider(
                    height: 35,
                    thickness: 0.8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      _loading
                          ? PriceLoading()
                          : finalprice == 0
                              ? Text(
                                  "$rupee ${widget.price}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )
                              : Text(
                                  "$rupee $finalprice",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                    ],
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, bottom: 5.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // height: 90,
                          width: 80,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Image.asset(
                                  noContact,
                                  scale: 2.5,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "No Contact",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Delivery",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          // height: 90,
                          width: 80,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Image.asset(
                                  deliverd,
                                  scale: 2.5,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Timely",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Delivered",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          // height: 90,
                          width: 80,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Image.asset(
                                  reture,
                                  scale: 2.5,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Easy",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Return",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          // height: 90,
                          width: 80,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Image.asset(
                                  pay,
                                  scale: 2.5,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Secure",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Payment",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
