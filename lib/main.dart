import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Updated from 'latlong'
import 'package:flutter_rating/flutter_rating.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(), 
    debugShowCheckedModeBanner: false
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Replaces the old SplashScreen package logic
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AfterSplash()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/playa.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.red),
        ),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  const AfterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(10.4902726, -75.4839263), // Changed from 'center'
          initialZoom: 14.0, // Changed from 'zoom'
        ),
        children: [ // Changed from 'layers'
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.museovivo.app',
          ),
          MarkerLayer(
            markers: [
              _buildMarker(context, 10.4887521, -75.4675819, 'assets/cubiertos.png', 25, Restaurantes()),
              _buildMarker(context, 10.4972435, -75.4710722, 'assets/trenzas.png', 5, Trenzas()),
              _buildMarker(context, 10.4937795, -75.497907, 'assets/lancha.png', 15, Lanchas()),
              _buildMarker(context, 10.4867406, -75.4767318, 'assets/chiva.png', 7, Chivas()),
              _buildMarker(context, 10.49888, -75.4792201, 'assets/manos.png', 7, Masajes()),
            ],
          ),
        ],
      ),
      Positioned(
        left: 0.0,
        bottom: 0.0,
        child: Image.asset('assets/cangrejo.png', scale: 6),
      ),
      Positioned(
        left: 50.0,
        bottom: 50.0,
        child: Image.asset('assets/globo.png'),
      ),
      const Positioned(
        left: 90.0,
        bottom: 150.0,
        child: Text("Pulsa uno de los\nservicios",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center),
      ),
    ]);
  }

  Marker _buildMarker(BuildContext context, double lat, double lng, String asset, double imgScale, Widget destination) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      child: GestureDetector( // 'builder' replaced by 'child'
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
        child: Image.asset(asset, scale: imgScale),
      ),
    );
  }
}

// --- Sub-pages ---

class Restaurantes extends StatelessWidget {
  const Restaurantes({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseDetailScreen(
      title: 'Restaurante: Donde Lucho',
      image: 'assets/restaurante.jpeg',
      rating: 4.2,
      description: 'Se fundó en el año de 1991, con la unión de dos esposos para ofrecer un servicio de restaurante de excelente calidad.',
    );
  }
}

class Trenzas extends StatelessWidget {
  const Trenzas({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseDetailScreen(
      title: 'Trenzas: La negra Tomasa',
      image: 'assets/trenzas.jpeg',
      rating: 4.0,
      description: 'La negra Tomasa te hará las mejores trenzas, con una atención única.',
    );
  }
}

class Lanchas extends StatelessWidget {
  const Lanchas({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseDetailScreen(
      title: 'Lancha: Rancho IV',
      image: 'assets/lancha.jpg',
      rating: 4.5,
      description: 'Conoce la región en Rancho IV de manera segura y divertida.',
    );
  }
}

class Chivas extends StatelessWidget {
  const Chivas({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseDetailScreen(
      title: 'Chiva: El Caporal',
      image: 'assets/chiva.jpg',
      rating: 4.5,
      description: 'Conoce la región en El Caporal de manera segura y divertida.',
    );
  }
}

class Masajes extends StatelessWidget {
  const Masajes({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseDetailScreen(
      title: 'Masajes: La Niña Tulia',
      image: 'assets/masajes.png',
      rating: 4.5,
      description: 'Masajes relajantes para aliviar la tensión ofrecidos por La Niña Tulia.',
    );
  }
}

// Reusable Detail Screen to clean up your code
class BaseDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final double rating;
  final String description;

  const BaseDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.rating,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Museo Vivo")),
      body: Stack(children: <Widget>[
        ListView(children: [
          Image.asset(image, width: 600, height: 240, fit: BoxFit.cover),
          StarRating(rating: rating, size: 40.0, color: Colors.orange),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(description, softWrap: true, textAlign: TextAlign.justify),
              ),
            ],
          ),
        ]),
        Positioned(
          left: -50.0,
          top: 240.0,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: Image.asset('assets/cangrejo.png', scale: 6),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        label: const Text("Solicitar servicio"),
        onPressed: () {},
      ),
    );
  }
}