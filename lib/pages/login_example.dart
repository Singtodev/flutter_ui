import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageExample extends StatelessWidget {
  const LoginPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('ทดสอบ Google Font!',
                      style: GoogleFonts.sarabun(
                          textStyle: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))),
                ),
                SizedBox(
                  width: 200.w,
                  height: 32.h,
                  child: const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => {},
                            child: const Text('Elevated Button')),
                        FilledButton(
                            onPressed: () => {},
                            child: const Text('Filled Button')),
                        OutlinedButton(
                            onPressed: () => {},
                            child: const Text('Outlined Button')),
                        IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.add_sharp)),
                        Image.asset('assets/images/pepe.jpg'),
                        Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2-TVphB148wg1omRxgqXTMk9lDbLyunCmdw&s'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
