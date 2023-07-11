import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class showtoast {
  showToast(String Text) {
    return Fluttertoast.showToast(
        msg: Text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
