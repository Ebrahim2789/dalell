import 'package:flutter/material.dart';
import 'package:dalell/routes.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ProfileEdit',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {}),
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
                child: Image.asset(
                    'assets/images/user.png'), // Replace with actual asset path
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit),),
              const SizedBox(height: 20),
              // Mobile Account
              const Text('Mobile Account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: '+251 | Please input mobile account',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Password
              const Text('Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please input password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password
              const Text('Confirm Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please enter password again',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              // Invitation Code
              const Text(' Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Please enter the  code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Save',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              // Login Link
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteGenerator.HomePages);
                },
                child: const Text('BackHome', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/images/dog.png',
        width: 180,
        height: 180,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

Widget _buildDetailsRow(String handiling, String value) {
  return Row(
    children: [
      Text(
        handiling,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'PlaywriteCOGuides',
        ),
      ),
      Text(value),
    ],
  );
}

class ProfileAction extends StatelessWidget {
  const ProfileAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconData(Icons.face, 'face'),
        _buildIconData(Icons.favorite, 'favorite'),
        _buildIconData(Icons.directions_walk, 'Walking'),
      ],
    );
  }
}

Widget _buildIconData(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        Text(text)
      ],
    ),
  );
}

class BuildStarRating extends StatelessWidget {
  final double size;
  final Color color;
  final int value;
  const BuildStarRating(
      {super.key,
      required this.size,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        value,
        (_) => Padding(
          padding: const EdgeInsets.all(2.2),
          child: Icon(
            Icons.star,
            color: color,
            size: size,
          ),
        ),
      ),
    );
  }
}
