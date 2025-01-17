import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uasmobile/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Check if the user is logged in
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Set profile data based on the user's email
    String namaLengkap = "";
    String nrp = "";
    String jurusan = "Informatika"; // Set jurusan (department)
    String imagePath = '';

    if (user.email == "irfan.satria@mhs.itenas.ac.id") {
      namaLengkap = "Irfan Satria Supriadi";
      nrp = "15-2022-026";
      imagePath = 'lib/img/ipeung.jpg';  // Path for Irfan
    } else if (user.email == "freddy.kristian@mhs.itenas.ac.id") {
      namaLengkap = "Freddy Kristian Putra";
      nrp = "15-2022-073";
      imagePath = 'lib/img/xambo.jpg';  // Path for Freddy
    } else {
      namaLengkap = "Unknown User";
      nrp = "Unknown";
      imagePath = 'lib/img/default.jpg';  // Default image for unknown users
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile Pembuat',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color.fromARGB(255, 116, 53, 242),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Profile Picture
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(imagePath), // Dynamically set image path
                ),
              ),
              const SizedBox(height: 20),
              // Full Name
              Align(
                alignment: Alignment.center,
                child: Text(
                  namaLengkap,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // NRP
              Align(
                alignment: Alignment.center,
                child: Text(
                  "NRP: $nrp",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Jurusan (Department)
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Jurusan: $jurusan",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Email
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Email: ${user.email}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Logout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(116, 53, 242, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // Show loading indicator for sign-out
                      await auth.signOut();

                      // Navigate to the login page
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    } catch (e) {
                      // Show an error message if logout fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Logout failed: ${e.toString()}"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space before About section

              // About This App Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About This App",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '''"Cuaca Cuacaan" is a weather app that provides real-time weather updates from the BMKG (Badan Meteorologi, Klimatologi, dan Geofisika) API. Stay informed with accurate forecasts, including temperature, humidity, and rainfall, to help you plan your day and stay prepared for any weather changes.''',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Version: 1.0.0",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}