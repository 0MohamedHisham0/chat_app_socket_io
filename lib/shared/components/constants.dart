import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../views/login/login.dart';
import '../network/local/cache_helper.dart';

const appName = 'Quick Chat';
const serverUrl = 'https://chat-yotta.herokuapp.com/'; //backend hosting api url: PORT

const mainColor = 0xFF046B5E;
const mainSecondColor = 0xFFFFFFFF;

const mainColorMaterial= MaterialColor(
  0xFF046B5E,
  <int, Color>{
    50: Color(0xFF046B5E),
    100: Color(0xFF046B5E),
    200: Color(0xFF046B5E),
    300: Color(0xFF046B5E),
    400: Color(0xFF046B5E),
    500: Color(0xFF046B5E),
    600: Color(0xFF046B5E),
    700: Color(0xFF046B5E),
    800: Color(0xFF046B5E),
    900: Color(0xFF046B5E),
  },
);


void signOut(BuildContext context) {
  CacheHelper.removeData(key: "userRole").then((value) => {
    CacheHelper.removeData(key: "token"),
    navigateAndFinish(
      context,
      LoginScreen(),
    ),
    showToast(text: "تم تسجيل الخروج بنجاح", state: ToastStates.SUCCESS)
  });
}

String? token;
String? userID;

Future navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
