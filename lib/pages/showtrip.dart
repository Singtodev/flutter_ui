import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowTripPage extends StatefulWidget {
  const ShowTripPage({super.key});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('รายการทริป'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                scrollNavigation(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      CardTrip(
                        title: "UnseenSwitzerland",
                        image:
                            'https://happylongway.com/wp-content/uploads/2019/01/GORNERGRAT-800x500.jpg',
                        country: 'ประเทศสวิตเซอร์แลนด์',
                        price: 'ราคา 119900 บาท',
                        duration: 'ระยะเวลา 10 วัน',
                      ),
                      CardTrip(
                        title: "Merlion Park",
                        image:
                            'https://www.ktc.co.th/pub/media/Travel-Story/Asia/travel-in-singapore/Merlion-Park.webp',
                        country: 'ประเทศสิงคโปร',
                        price: 'ราคา 119900 บาท',
                        duration: 'ระยะเวลา 10 วัน',
                      ),
                      CardTrip(
                        title: "Sunworld  Ba Na Hills",
                        image:
                            'https://www.you.co/th/wp-content/uploads/sites/9/2020/06/Ba-Na-Hills.jpg',
                        country: 'ประเทศเวียดนาม',
                        price: 'ราคา 119900 บาท',
                        duration: 'ระยะเวลา 10 วัน',
                      ),
                      CardTrip(
                        title: "Cong Vien Apec",
                        image:
                            'https://www.you.co/th/wp-content/uploads/sites/9/2020/06/Cong-Vien-Apec.jpg',
                        country: 'ประเทศเวียดนาม',
                        price: 'ราคา 119900 บาท',
                        duration: 'ระยะเวลา 10 วัน',
                      ),
                      CardTrip(
                        title: "Cong Vien Apec 1",
                        image:
                            'https://www.you.co/th/wp-content/uploads/sites/9/2020/06/Cong-Vien-Apec.jpg',
                        country: 'ประเทศเวียดนาม',
                        price: 'ราคา 119900 บาท',
                        duration: 'ระยะเวลา 10 วัน',
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  SizedBox scrollNavigation() {
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryItem(label: "ทั้งหมด"),
          CategoryItem(label: "เอเชีย"),
          CategoryItem(label: "ยุโรป"),
          CategoryItem(label: "อาเซี่ยน"),
          CategoryItem(label: "อเมริกา"),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class CardTrip extends StatelessWidget {
  CardTrip(
      {super.key,
      required this.title,
      required this.image,
      required this.country,
      required this.price,
      required this.duration});

  late String title = "";
  late String image = "";
  late String price = "";
  late String country = "";
  late String duration = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5.sp,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.sp),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 160.w,
                    child: Image.network(image),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        duration,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        price,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: FilledButton(
                            onPressed: () => {},
                            child: Text(
                              'รายละเอียดเพิ่มเตืม',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.label});

  late String label = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.sp),
      child: FilledButton(
          onPressed: () {},
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          )),
    );
  }
}
