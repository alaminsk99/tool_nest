import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tool_nest/core/constants/colors.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

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





  static void navigateToScreen(BuildContext context, Widget screen) {
    if (context.mounted) {
      Navigator.push(

        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }


  static String truncateText(String text, int maxLength){
    if(text.length <= maxLength){
      return text;
    }else{
      return '${text.substring(0,maxLength)}...';
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

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize, {double spacing = 8.0}) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(
        Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            children: rowChildren,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      );
    }
    return wrappedList;
  }




}