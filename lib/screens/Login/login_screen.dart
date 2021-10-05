import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  bool _hide = true;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _formkey = GlobalKey<FormState>();

   _launchURL(String url) async {
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(_username.value);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text(
        //     "Login ",
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
        body: _loading ? _ol(_body(width, height)) : _body(width, height),

        // body: _loading
        //     ? Center(
        //         child: Container(
        //           color: Colors.white30,
        //           child: CircularProgressIndicator(),
        //         ),
        //       )
        //     : Container(
        //         child: SingleChildScrollView(
        //             child: Column(
        //           // crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               height: 350,
        //               width: double.infinity,
        //               decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                   image: AssetImage(
        //                     loginbg,
        //                   ),
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //               child: Column(
        //                 children: [
        //                   SizedBox(
        //                     height: 85.0,
        //                   ),
        //                   Image.asset(
        //                     loginlogo,
        //                     width: 150,
        //                   ),
        //                   SizedBox(
        //                     height: 55.0,
        //                   ),
        //                   Text(
        //                     "Welcome",
        //                     style: GoogleFonts.poppins(
        //                       fontSize: 25.0,
        //                       color: tabColor,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             SizedBox(
        //               height: 10.0,
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 20, top: 10.0, bottom: 1.0),
        //               child: Align(
        //                 alignment: Alignment.topLeft,
        //                 child: Text(
        //                   "Email",
        //                   style: GoogleFonts.poppins(
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 20.0, right: 20.0, top: 0, bottom: 10.0),
        //               // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
        //               child: TextField(
        //                 controller: _username,
        //                 decoration: InputDecoration(
        //                     border: OutlineInputBorder(),
        //                     labelText: 'Enter email',
        //                     hintText: 'Enter valid email id as abc@gmail.com'),
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 20, top: 10.0, bottom: 1.0),
        //               child: Align(
        //                 alignment: Alignment.topLeft,
        //                 child: Text(
        //                   "Password",
        //                   style: GoogleFonts.poppins(
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               // padding: const EdgeInsets.only(
        //               //     left: 15.0, right: 15.0, top: 15, bottom: 0),
        //               padding: const EdgeInsets.only(
        //                   left: 20.0, right: 20.0, top: 0, bottom: 10.0),
        //               child: TextField(
        //                 controller: _password,
        //                 obscureText: _hide,
        //                 decoration: InputDecoration(
        //                     suffixIcon: Container(
        //                       child: IconButton(
        //                           onPressed: () {
        //                             print("hide");
        //                             setState(() {
        //                               _hide = !_hide;
        //                             });
        //                           },
        //                           icon: Icon(
        //                             Icons.remove_red_eye,
        //                           )),
        //                     ),
        //                     border: const OutlineInputBorder(),
        //                     labelText: 'Enter Password',
        //                     hintText: 'Enter secure password'),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 25.0,
        //             ),
        //             ElevatedButton.icon(
        //               style: ElevatedButton.styleFrom(
        //                   primary: tabColor,
        //                   textStyle: GoogleFonts.poppins(
        //                     fontSize: 17.0,
        //                   ),
        //                   padding: const EdgeInsets.all(8.0),
        //                   minimumSize: Size(356, 50)),
        //               onPressed: () async {
        //                 setState(() {
        //                   _loading = true;
        //                 });
        //                 user = await CartData.woocommerce.loginCustomer(
        //                   username: _username.text,
        //                   password: _password.text,
        //                 );
        //                 // user = await CartData.woocommerce.loginCustomer(username: username, password: password)
        //                 setState(() {
        //                   _loading = false;
        //                   Navigator.pushReplacement(context,
        //                       MaterialPageRoute(builder: (context) => Home()));
        //                 });
        //                 print(user.id);
        //               },
        //               icon: const Icon(Icons.arrow_forward),
        //               label: const Text("LOGIN"),
        //             ),
        //             // _loading ? CircularProgressIndicator() : Container(),
        //             SizedBox(
        //               height: 20.0,
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 20.0, right: 20.0, top: 0, bottom: 10.0),
        //               child: Row(
        //                 children: [
        //                   TextButton(
        //                     style: TextButton.styleFrom(
        //                       primary: tabColor,
        //                     ),
        //                     onPressed: () {
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (_) => SignUpScreen()));
        //                     },
        //                     child: Text(
        //                       "Sign up",
        //                       style: TextStyle(
        //                         decoration: TextDecoration.underline,
        //                       ),
        //                     ),
        //                   ),
        //                   Spacer(),
        //                   TextButton(
        //                     style: TextButton.styleFrom(
        //                       primary: tabColor,
        //                     ),
        //                     onPressed: () {},
        //                     child: Text(
        //                       "Forgot Password?",
        //                       style: TextStyle(
        //                         decoration: TextDecoration.underline,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             // ElevatedButton.icon(
        //             //   onPressed: () {
        //             //     Navigator.push(context,
        //             //         CupertinoPageRoute(builder: (context) => SignUpScreen()));
        //             //   },
        //             //   icon: const Icon(Icons.login),
        //             //   label: const Text("signUp"),
        //             // ),
        //           ],
        //         )),
        //       ),
      ),
    );
  }

  Widget _body(width, height) {
    return Form(
      key: _formkey,
      child: Container(
        child: SingleChildScrollView(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height / 2.1,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    loginbg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 85.0,
                  ),
                  Image.asset(
                    loginlogo,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 55.0,
                  ),
                  Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      fontSize: 35.0,
                      color: Color(0xFfF0B26C),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    "Sign in to continue",
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
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
                    return "Please check email";
                  }
                  return null;
                },
                controller: _username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter email',
                  hintText: 'Enter username',
                ),
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
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
                controller: _password,
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
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: tabColor,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(width / 1.18, 50),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                   
                    setState(() {
                        _loading = true;
                      });

                    var user = await CartData.woocommerce.loginCustomer(
                      username: _username.text,
                      password: _password.text,
                    );
                    if (user.runtimeType == String) {
                      setState(() {
                        _loading = false;
                      });
                      Get.defaultDialog(
                        title: "Alert!",
                        middleText:
                            "The username or Password You entered is incorrect please try again ",
                        onConfirm: () {
                          Navigator.pop(context);
                        },
                        textConfirm: "Ok",
                      );
                    } else {
                      setState(() {
                        _loading = false;
                         Get.offAll(()=>Home());
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     new MaterialPageRoute(builder: (context) => Home()),
                        //     (route) => false);
                      });
                    }

                    // return err;

                    // var err = await CartData.woocommerce.loginCustomer(
                    //   username: _username.text,
                    //   password: _password.text,
                    // );

                    // user = await CartData.woocommerce.loginCustomer(username: username, password: password)

                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("LOGIN"),
              ),
            ),
            // _loading ? CircularProgressIndicator() : Container(),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0, bottom: 10.0),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: tabColor,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: tabColor,
                    ),
                    onPressed: () {
                      _launchURL("https://www.incredibleman.in/my-account/lost-password/");
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.push(context,
            //         CupertinoPageRoute(builder: (context) => SignUpScreen()));
            //   },
            //   icon: const Icon(Icons.login),
            //   label: const Text("signUp"),
            // ),
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
                    child: LottieBuilder.asset(loading),
                    // child: new SizedBox(
                    //   height: 50.0,
                    //   width: 50.0,
                    //   child: new CircularProgressIndicator(
                    //     value: null,
                    //     strokeWidth: 7.0,
                    //   ),
                    // ),
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
