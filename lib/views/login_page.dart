import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign in or create account'),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // ),
          backgroundColor: Colors.orange[800],
        ),
        backgroundColor: Colors.orange[800],
        body: Stack(children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          )),
          Container(
            //      decoration:  const BoxDecoration(
            //           image: DecorationImage(image: AssetImage('assets/images/background.jpg'),

            //           fit: BoxFit.cover,

            //           ),

            //         ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Making global trading\nsimple',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.g_translate), // Placeholder for Google icon
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('OR', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  label: const Text('Sign in with Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email),
                  label: const Text('Continue with email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                const SizedBox(height: 32),
                // Placeholder for image of person holding box
                Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Person holding box')),
                ),
              ],
            ),
          ),
        ]));
  }
}
