import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _loading = false;
  bool _hide = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _firstname = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: _loading ? _ol(_body(height, width)) : _body(height, width),
      ),
    );
  }

  Widget _body(height, width) {
    return Form(
      key: _formkey,
      child: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: height / 3.5,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    signupbg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Image.asset(
                    loginlogo,
                    scale: 4.5,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      fontSize: 30.0,
                      color: Color(0xFfF0B26C),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "FirstName",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 0, bottom: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter firstname';
                  }
                  return null;
                },
                controller: _firstname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Firstname',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LastName",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 0, bottom: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Lastname';
                  }
                  return null;
                },
                controller: _lastname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Lastname',
                  hintText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 0, bottom: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter email',
                    hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              // padding: const EdgeInsets.only(
              //     left: 15.0, right: 15.0, top: 15, bottom: 0),
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 0, bottom: 10.0),
              child: TextFormField(
                controller: _password,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                obscureText: _hide,
                decoration: InputDecoration(
                    suffixIcon: Container(
                      child: IconButton(
                          onPressed: () {
                            print("hide");
                            setState(() {
                              _hide = !_hide;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                          )),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: tabColor,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    minimumSize: Size(width / 1.18, 50)),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    WooCustomer customer = WooCustomer(
                      firstName: _firstname.text,
                      lastName: _lastname.text,
                      username: _firstname.text,
                      email: _email.text,
                      password: _password.text,
                    );
                    try {
                      await CartData.woocommerce
                          .createCustomer(customer)
                          .then((value) async {
                        if (value == true) {
                          await CartData.woocommerce.loginCustomer(
                            username: _firstname.text,
                            password: _password.text,
                          );
                          setState(() {
                            _loading = false;
                            Navigator.of(context).pushAndRemoveUntil(
                              new MaterialPageRoute(
                                  builder: (context) => Home()),
                              (route) => false,
                            );
                          });
                        }
                      });
                    } on Exception catch (e) {
                      print(e);
                      setState(() {
                        _loading = false;
                      });
                      Get.defaultDialog(
                          title: "Alert!", middleText: " User already exists");

                      // WooCommerceError e;
                      // // throw WooCommerceError;

                      // print("aaa try ni error ${e.code}");
                    }

                    // await CartData.woocommerce
                    //     .createCustomer(customer)
                    //     .then((val) async {
                    //   print(val);
                    //   // var us = await CartData.woocommerce.loginCustomer(
                    //   //   username: _firstname.text,
                    //   //   password: _password.text,
                    //   // );

                    //   setState(() {
                    //     _loading = false;
                    //
                    //     // print(us);
                    //   });
                    // });
                  }

                  // bool created =
                  //     await CartData.woocommerce.createCustomer(customer);
                },
                icon: Icon(Icons.arrow_back),
                label: Text("REGISTER"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: tabColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _ol(Widget body) {
    return Container(
      child: new Stack(
        children: <Widget>[
          body,
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              // decoration: new BoxDecoration(
              //     color: Colors.white70,
              //     borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
