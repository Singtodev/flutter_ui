// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/models/customer_data_response.dart';
import 'package:flutter_ui/pages/auth.dart';
import 'package:flutter_ui/pages/showtrip.dart';
import 'package:flutter_ui/services/customer.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final CustomerService customerSrv = CustomerService();

  Future<CustomerDataResponse?> loadDataCustomer(String id) async {
    try {
      CustomerDataResponse customer = await customerSrv.getCustomer(id);
      return customer;
    } catch (error) {
      debugPrint("Error fetching customer: $error");
      return null;
    }
  }

  Future<void> uploadDataCustomer() async {
    try {
      CustomerDataResponse body = CustomerDataResponse(
          idx: int.parse(widget.userId),
          image: imageController.text,
          fullname: fullNameController.text,
          phone: phoneNumberController.text,
          email: emailController.text);
      await customerSrv.putCustomer(body.idx.toString(), body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated')),
      );
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('สำเร็จ'),
                content: const Text('บันทึกข้อมูลเรียบร้อย'),
                actions: [
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ปิด'))
                ],
              ));
    } catch (err) {
      debugPrint("Error fetching customer: $err");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('บันทึกข้อมูลไม่สำเร็จ ' + err.toString()),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
  }

  Future<void> deleteUser() async {
    await customerSrv.deleteCustomer(widget.userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Delete Updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              debugPrint(value);
              if (value == 'logout') {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
              if (value == 'trips') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowTripPage()));
              }
              if (value == 'delete') {
                deleteUser();
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'trips',
                child: Text('แสดงtrips'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('ยกเลิกสมาชิก'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<CustomerDataResponse?>(
          future: loadDataCustomer(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;
              fullNameController.text = user.fullname ?? '';
              phoneNumberController.text = user.phone ?? '';
              emailController.text = user.email ?? '';
              imageController.text = user.image ?? '';
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClipOval(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: CachedNetworkImage(
                            imageUrl: user.image?.toString() ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InputBox(
                      controller: fullNameController,
                      type: TextInputType.name,
                      title: "Full Name",
                      obscureText: false,
                      enableSuggestions: true,
                    ),
                    const SizedBox(height: 16),
                    InputBox(
                      controller: phoneNumberController,
                      type: TextInputType.phone,
                      title: "Phone Number",
                      obscureText: false,
                      enableSuggestions: false,
                    ),
                    const SizedBox(height: 16),
                    InputBox(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      title: "Email",
                      obscureText: false,
                      enableSuggestions: true,
                    ),
                    InputBox(
                      controller: imageController,
                      type: TextInputType.text,
                      title: "Image",
                      obscureText: false,
                      enableSuggestions: true,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: () async {
                        uploadDataCustomer();
                      },
                      child: const Text('บันทึกข้อมูล'),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

// Your InputBox widget remains the same
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
