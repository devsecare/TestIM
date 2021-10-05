import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final Widget body;
  const Loading({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              height: 300.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      
                      child: LottieBuilder.asset(loading),
                    ),
                  ),
                  new Container(
               
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
