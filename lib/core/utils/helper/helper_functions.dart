import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';


class TNHelperFunctions{


  static void showSnackBar(String message, {Color? bgColor, Color? textColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
    );
  }
  static void showAlert(String title,String message,BuildContext context){
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.of(context).pop(),
              child: const  Text("OK"),
            ),
          ],
        );
      },
    );
  }


  static void showDialogWithWidgets(
      BuildContext context,
      Widget widget, {
        bool barrierDismissible = true,
      }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }







  static void navigateToScreenAndBack(BuildContext context, String screen) {
    if (context.mounted) {
      context.goNamed(screen);
    }

  }
  static void navigateToScreenAndNotBack(BuildContext context, String screen) {
    if (context.mounted) {
      context.go(screen);
    }
  }




  static bool isDarkMode(BuildContext context ){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static  Size screenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static double screenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  void  showToastMessage(String message){
    Fluttertoast.showToast(msg: message,backgroundColor: TNColors.primary,textColor: TNColors.white);
  }

  // static String getFormattedDate(DateTime date,{String format = 'dd MM yyyy'}){
  //   return DateFormat(format).format(date);
  // }

  static List<T> removeDuplicates<T>(List<T> list){
    return list.toSet().toList();
  }
  static Future<bool> isDeviceOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }




}