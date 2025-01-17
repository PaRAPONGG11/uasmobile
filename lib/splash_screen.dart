import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uasmobile/login.dart'; // Import halaman Login

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showInitialScreen = true; // Status untuk menampilkan layar pertama
  bool _showSecondImage = false; // Status untuk menampilkan gambar kedua

  @override
  void initState() {
    super.initState();

    // Timer untuk menampilkan gambar pertama selama 2 detik
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showInitialScreen = false;
        _showSecondImage = true;
      });
    });

    // Timer untuk menampilkan gambar kedua selama 2 detik
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _showSecondImage = false;
      });
    });

    // Timer untuk menampilkan animasi Lottie selama 5 detik
    Timer(const Duration(seconds: 9), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background sesuai warna tombol di Login
      backgroundColor: const Color.fromRGBO(116, 53, 242, 1),
      body: Center(
        child: _showInitialScreen
            ? _buildFirstImage() // Tampilan pertama (gambar pertama)
            : _showSecondImage
            ? _buildSecondImage() // Tampilan kedua (gambar kedua)
            : _buildAnimationScreen(), // Tampilan ketiga (animasi Lottie)
      ),
    );
  }

  // Widget untuk gambar pertama
  Widget _buildFirstImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            width: 120,
            height: 120,
            child: Image.asset(
              'lib/img/ipeung.jpg', // Path gambar pertama
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Nama: Irfan Satria Supriadi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Warna teks disesuaikan
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'NRP: 15-2022-26',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70, // Warna teks disesuaikan
          ),
        ),
      ],
    );
  }

  // Widget untuk gambar kedua
  Widget _buildSecondImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            width: 120,
            height: 120,
            child: Image.asset(
              'lib/img/xambo.jpg', // Path gambar kedua
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Nama: Freddy Kristian Putra',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Warna teks disesuaikan
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'NRP: 15-2022-73',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70, // Warna teks disesuaikan
          ),
        ),
      ],
    );
  }

  // Widget untuk animasi Lottie
  Widget _buildAnimationScreen() {
    return Lottie.asset(
      'lib/animation/animate.json', // Path file Lottie animasi
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}