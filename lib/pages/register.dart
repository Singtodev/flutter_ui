import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/models/customer_created_response.dart';
import 'package:flutter_ui/models/customer_post_body.dart';
import 'package:flutter_ui/services/auth.dart';
import '../configs/environment.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController =
      TextEditingController();
  late AuthenticationService authSrv = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ลงทะเบียนสมาชิกใหม่'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  InputBox(
                    title: "ชื่อนาม-สกุล",
                    controller: fullNameController,
                    type: TextInputType.text,
                    obscureText: false,
                    enableSuggestions: false,
                  ),
                  InputBox(
                    title: "หมายเลขโทรศัพท์",
                    controller: phoneNumberController,
                    type: TextInputType.phone,
                    obscureText: false,
                    enableSuggestions: false,
                  ),
                  InputBox(
                    title: "อีเมลล์",
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    obscureText: false,
                    enableSuggestions: false,
                  ),
                  InputBox(
                    title: "รหัสผ่าน",
                    controller: passwordController,
                    type: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                  ),
                  InputBox(
                    title: "ยืนยันรหัสผ่าน",
                    controller: confirmPasswordController,
                    type: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 180.w,
                              child: FilledButton(
                                  onPressed: () => {registerAction()},
                                  child: const Text(
                                    'สมัครสมาชิก',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'หากมีบัญชีอยู่แล้ว',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: Text(
                                'เข้าสู่ระบบ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> registerAction() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      // If any field is empty, return early without making the request
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Notification'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    if (passwordController.text != confirmPasswordController.text) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notification'),
            content: const Text('Password not matched'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    CustomerPostBody bodyData = CustomerPostBody(
        fullname: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneNumberController.text,
        image: "");
    await authSrv
        .register(bodyData)
        .then((res) => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Notification'),
                    content: const Text('Register Successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              )
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => {debugPrint(error.toString())});
  }
}

// ignore: must_be_immutable
class InputBox extends StatelessWidget {
  InputBox(
      {super.key,
      required this.controller,
      required this.type,
      required this.title,
      required this.obscureText,
      required this.enableSuggestions});

  final TextEditingController controller;
  late TextInputType type = TextInputType.text;
  late String title = "";
  late bool obscureText = false;
  late bool enableSuggestions = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: TextField(
            obscureText: obscureText,
            enableSuggestions: enableSuggestions,
            controller: controller,
            keyboardType: type,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10)),
          ),
        ),
      ],
    );
  }
}
