import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'constants.dart';
import '../../views/login/login.dart';

Widget backButton(context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          const Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget entryField(String title,
    {bool isPassword = false,
    required TextEditingController controller,
    required String validationMessage}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: (value) {
              if (value!.isEmpty) {
                return validationMessage;
              }
              return null;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}

Widget submitButton(context, Function onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(mainColor), Color(mainSecondColor)])),
      child: const Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget loginAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Login',
            style: TextStyle(
                color: Color(mainSecondColor),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget title() {
  return RichText(
    textAlign: TextAlign.center,
    text: const TextSpan(
        text: 'd',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w700, color: Color(mainColor)),
        children: [
          TextSpan(
            text: 'ev',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'rnz',
            style: TextStyle(color: Color(mainColor), fontSize: 30),
          ),
        ]),
  );
}

Widget emailPasswordWidget({
  required emailController,
  required passwordController,
  required userNameController,
  required formKey,
}) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        entryField("Username",
            controller: userNameController,
            validationMessage: "Username is required"),
        entryField("Email",
            controller: emailController,
            validationMessage: "Email is required"),
        entryField("Password",
            isPassword: true,
            controller: passwordController,
            validationMessage: "Password is required"),
      ],
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 0.3,
      color: const Color(mainColor),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = const Color(mainColor),
  bool isUpperCase = true,
  double radius = 3.0,
  required Function? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          function!();
        },
        style: ElevatedButton.styleFrom(
          primary: background,
        ),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget progressLoading() => const Center(
      child: SpinKitFadingCube(
        color: Color(mainColor),
      ),
    );

Widget errorWidget(String error) => Center(
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Text(
            error,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
