import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                  const FooterAction()
                ],
              ),
            ),
          ),
        ));
  }
}

class FooterAction extends StatelessWidget {
  const FooterAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180.w,
                child: FilledButton(
                    onPressed: () => {},
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    )),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'หากมีบัญชีอยู่แล้ว',
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
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
    );
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
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                title,
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
            obscureText: obscureText,
            enableSuggestions: enableSuggestions,
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.w)),
          ),
        ),
      ],
    );
  }
}
