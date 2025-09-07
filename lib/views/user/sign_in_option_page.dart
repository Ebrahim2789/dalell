import 'package:dalell/routes/routes.dart';
import 'package:dalell/views/user/bloc/auth_bloc.dart';
import 'package:dalell/views/user/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // late AuthBloc _authBloc; 


 


  
  @override
  Widget build(BuildContext context) {
    
    return  BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Navigate based on user role
          if (state.user.role == 'admin') {
            Navigator.pushReplacementNamed(context, RouteGenerator.marchentPages);
          } else {
            Navigator.pushReplacementNamed(context, RouteGenerator.homePages);
          }
        }
        if (state is AuthAuthenticated) {
          // Show error or stay on login
        }
      },
      child: 
    
    Scaffold(
        appBar: AppBar(
          title: const Text('Sign in or create account'),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // ),
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.orange[800],
        body: Stack(children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          )),
          Container(
                 decoration:  const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/background.jpg'),

                      fit: BoxFit.cover,

                      ),

                    ),
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
                  onPressed: () async{
                      bool loggedIn = await isLoggedIn();

                    if(!loggedIn){
                    Navigator.pushReplacementNamed(context, RouteGenerator.loginScreen);
                    }
                  },
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
        ])));
  }
}
