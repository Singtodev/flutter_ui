import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/models/trip_response.dart';
import 'package:flutter_ui/pages/show_trip_id.dart';
import 'package:flutter_ui/services/trip.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowTripPage extends StatefulWidget {
  const ShowTripPage({super.key});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  late TripService tripSrv = TripService();
  String selectedZone = "";
  late Future<List<TripResponse>> tripsFuture;
  @override
  void initState() {
    super.initState();
    tripsFuture = fetchTrip();
  }

  Future<List<TripResponse>> fetchTrip() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      List<TripResponse> trips = await tripSrv.getTrips();
      if (selectedZone.isEmpty) {
        return trips;
      } else {
        return trips.where((TripResponse trip) {
          String tripZone =
              destinationZoneValues.reverse[trip.destinationZone] ?? "";
          return tripZone == selectedZone;
        }).toList();
      }
    } catch (error) {
      debugPrint("Error fetching trips: $error");
      return [];
    }
  }

  void updateTrips(String zone) {
    setState(() {
      selectedZone = zone;
      tripsFuture = fetchTrip();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('รายการทริป'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                scrollNavigation(),
                Expanded(
                  child: FutureBuilder<List<TripResponse>>(
                    future: tripsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No trips available'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final trip = snapshot.data![index];
                            return CardTrip(
                                title: trip.name ?? '',
                                image: trip.coverimage ?? '',
                                country: trip.country ?? '',
                                price: "ราคา ${trip.price ?? ''}",
                                duration: 'ระยะเวลา ${trip.duration ?? ''} วัน',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShowTripIdPage(
                                              tripId: trip.idx.toString())));
                                });
                          },
                        );
                      }
                    },
                  ),
                ),
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
          CategoryItem(
            label: "ทั้งหมด",
            onTap: () => updateTrips(""),
          ),
          CategoryItem(
            label: "เอเชีย",
            onTap: () => updateTrips("เอเชีย"),
          ),
          CategoryItem(
            label: "เอเชียตะวันออกเฉียงใต้",
            onTap: () => updateTrips("เอเชียตะวันออกเฉียงใต้"),
          ),
          CategoryItem(
            label: "ยุโรป",
            onTap: () => updateTrips("ยุโรป"),
          ),
          CategoryItem(
            label: "ประเทศไทย",
            onTap: () => updateTrips("ประเทศไทย"),
          ),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class CardTrip extends StatelessWidget {
  final VoidCallback? onTap;
  CardTrip(
      {super.key,
      required this.title,
      required this.image,
      required this.country,
      required this.price,
      required this.duration,
      required this.onTap});

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
                    width: 160,
                    child: CachedNetworkImage(
                      imageUrl: image.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                            onPressed: () => {
                                  if (onTap != null) {onTap!()}
                                },
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
  final VoidCallback? onTap;
  late String label = "";
  CategoryItem({super.key, required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.sp),
      child: FilledButton(
          onPressed: () {
            debugPrint("Tapped category: $label");
            // updateTrips(label);
            if (onTap != null) {
              onTap!();
            }
          },
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          )),
    );
  }
}
