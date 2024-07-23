// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/pages/register.dart';
import 'package:flutter_ui/pages/showtrip.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  String text = "";
  int loginAttempt = 0;
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                    onTap: () {
                      print("Tab Logo");
                    },
                    onDoubleTap: () {
                      print("Double Tap Logo");
                    },
                    child: Image.asset('assets/images/logo.png')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'หมายเลขโทรศัพท์',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10.w)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'รหัสผ่าน',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10.w)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: registerAction,
                            child: Text(
                              'ลงทะเบียนใหม่',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            )),
                        FilledButton(
                            onPressed: loginAction,
                            child: Text(
                              'เข้าสู่ระบบ',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            )),
                      ],
                    )
                  ])),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerAction() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void loginAction() {
    if (phoneNumberController.text == "0812345678" &&
        passwordController.text == "1234") {
      setState(() {
        text = "Login Successfully";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ShowTripPage()));
    } else {
      setState(() {
        text = "Phone no or password incorrect";
      });
    }
  }
}