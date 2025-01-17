import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uasmobile/navbar.dart';
import 'package:uasmobile/daftar.dart'; // Halaman pendaftaran

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = ''; // Variabel untuk menampilkan error

  bool _isEmailValid(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  Future<void> _login() async {
    if (!_isEmailValid(_emailController.text)) {
      setState(() {
        _errorMessage = 'Format email tidak valid';
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigasi ke Navbar setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navbar(userEmail: _emailController.text),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'Email tidak ditemukan';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Password salah';
        } else {
          _errorMessage = 'Error: ${e.message}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ClipOval(
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'lib/img/Logo.png', // Gambar logo aplikasi
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 53, 242, 1),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Daftar()),
                  );
                },
                child: const Text('Belum punya akun? Daftar!'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}