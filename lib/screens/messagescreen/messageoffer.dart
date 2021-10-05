import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String msgoffer;
  const MessageScreen({ Key key, this.msgoffer }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Offers"),
        ),
        body: Container(
          child: Center(child: Text(widget.msgoffer),),

          
        ),
      ),
    );
  }
}