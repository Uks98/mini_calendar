import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastNotification{

  static void warningToast(String msg,){
    Fluttertoast.showToast(msg: msg,toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.black,textColor: Colors.white,fontSize: 16);
  }
}