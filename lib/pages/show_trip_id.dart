import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/models/trip_data_response.dart';
import 'package:flutter_ui/services/trip.dart';

class ShowTripIdPage extends StatefulWidget {
  final String tripId;

  const ShowTripIdPage({super.key, required this.tripId});

  @override
  State<ShowTripIdPage> createState() => _ShowTripIdPageState();
}

class _ShowTripIdPageState extends State<ShowTripIdPage> {
  late TripService tripSrv = TripService();

  Future<TripDataResponse> fetchShowTrip() async {
    await Future.delayed(const Duration(seconds: 1));
    TripDataResponse trip = await tripSrv.getTrip(widget.tripId);
    debugPrint("$trip");
    return trip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด'),
      ),
      body: FutureBuilder<TripDataResponse>(
        future: fetchShowTrip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No trip data available'));
          } else {
            final trip = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (trip.coverimage != null)
                    CachedNetworkImage(
                      imageUrl: trip.coverimage.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    trip.name ?? 'Unnamed Trip',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Country: ${trip.country ?? 'N/A'}'),
                  Text('Price: ${trip.price ?? 'N/A'}'),
                  Text('Duration: ${trip.duration ?? 'N/A'} days'),
                  Text('Destination Zone: ${trip.destinationZone ?? 'N/A'}'),
                  const SizedBox(height: 16),
                  Text(
                    'Details:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(trip.detail ?? 'No details available'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
