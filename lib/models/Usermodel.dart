import 'package:flutter/material.dart';
import 'package:dalell/views/rest_password.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'reg',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Placeholder for the store image/emoji
              SizedBox(
                height: 100,
     child: Image.asset('assets/images/user.png'), // Replace with actual asset path
              ),
              const SizedBox(height: 20),
              // Mobile Account
              const Text('Mobile Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: '+251 | Please input mobile account',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Password
              const Text('Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please input password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password
              const Text('Confirm Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please enter password again',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Invitation Code
              const Text('Invitation Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Please enter the invitation code',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Sign up', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              // Login Link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context,"/LoginPage" );
                },
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '/login', // Adjust URL as needed
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Placeholder for the store image/emoji
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/user.png'), // Replace with actual asset path
              ),
              const SizedBox(height: 20),
              // Mobile Account
              const Text('Mobile Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: '+251 | Please input mobile account',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Password
              const Text('Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please input password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),
              // Login Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              // Sign Up Link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Sign up', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


