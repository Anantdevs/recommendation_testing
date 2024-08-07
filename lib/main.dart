import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Nearby Doctor Recommender')),
        body: DoctorRecommendationPage(),
      ),
    );
  }
}
fucnt();
func3();
func3();
func3();
func3();
func3();
func3();
func3();
func3();
func3();


class DoctorRecommendationPage extends StatefulWidget {
  @override
  _DoctorRecommendationPageState createState() =>
      _DoctorRecommendationPageState();
}

class _DoctorRecommendationPageState extends State<DoctorRecommendationPage> {
  List<dynamic> _doctors = [];

  Future<void> _fetchRecommendations() async {
    // Static coordinates for San Francisco
    final double userLat = 37.7749;
    final double userLon = -122.4194;
    final double radius = 0; // 50 km radius

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/recommendations?lat=$userLat&lon=$userLon&radius=$radius'));

    if (response.statusCode == 200) {
      setState(() {
        _doctors = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _fetchRecommendations();
            },
            child: const Text('Fetch Recommendations'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _doctors.length,
              itemBuilder: (context, index) {
                final doctor = _doctors[index];
                return ListTile(
                  title: Text(doctor['name']),
                  subtitle: Text(
                      'Specialty: ${doctor['specialty']} - Distance: ${doctor['distance'].toStringAsFixed(2)} km'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
