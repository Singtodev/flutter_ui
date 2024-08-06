import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/models/trip_response.dart';
import 'package:flutter_ui/services/trip.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowTripPage extends StatefulWidget {
  const ShowTripPage({super.key});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  late TripService tripSrv = TripService();

  List<TripResponse> _trips = [];
  @override
  void initState() {
    super.initState();
    fetchTrip();
  }

  Future<void> fetchTrip() async {
    await tripSrv.getTrips().then((trips) {
      setState(() {
        _trips = trips;
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => {debugPrint(error.toString())});
  }

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
                    child: Column(
                        children: _trips
                            .map((trip) => CardTrip(
                                  title: trip.name.toString(),
                                  image: trip.coverimage.toString(),
                                  country: trip.country.toString(),
                                  price: "ราคา ${trip.price.toString()}",
                                  duration:
                                      'ระยะเวลา ${trip.duration.toString()} วัน',
                                ))
                            .toList()),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
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
                    child: CachedNetworkImage(
                      imageUrl: image.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
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
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        duration,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        price,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FilledButton(
                            onPressed: () => {},
                            child: const Text(
                              'รายละเอียดเพิ่มเตืม',
                              style: TextStyle(
                                fontSize: 12,
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
