import 'package:dalell/views/user/bloc/auth_event.dart';
import 'package:dalell/views/user/bloc/auth_state.dart';
import 'package:dalell/views/user/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';



class User {
  final String email;
  final String password;
  final String role; // For authorization (e.g., 'admin', 'user')

  User({required this.email, required this.password, required this.role});
}





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckAuthStatus()),
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWarpper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome, ${state.user.email}!'),
                    Text('Role: ${state.user.role}'),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


// ### Features of the Implementation
// 1. **Beautiful UI**:
//    - Gradient background for a modern look.
//    - Card-based form with elevation and rounded corners.
//    - Form fields with icons and validation.
//    - Smooth button design with loading state.

// 2. **Form Validation**:
//    - Email validation using regex.
//    - Password validation for minimum length.

// 3. **BLoC State Management**:
//    - Handles authentication states (`AuthInitial`, `AuthLoading`, `AuthAuthenticated`, `AuthError`).
//    - Static user data for demo purposes (admin and user roles).
//    - Events for login and logout.

// 4. **Authorization**:
//    - Role-based user model (`admin` or `user`).
//    - Post-login, you can navigate to role-specific screens (e.g., admin dashboard or user home).

// ### How to Run
// 1. Ensure you have Flutter installed.
// 2. Create a new Flutter project and replace the `lib` folder with the structure above.
// 3. Run `flutter pub get` to install dependencies.
// 4. Run the app with `flutter run`.

// ### Testing
// - **Valid Credentials**:
//   - Email: `admin@example.com`, Password: `admin123` (Role: admin)
//   - Email: `user@example.com`, Password: `user123` (Role: user)
// - **Invalid Credentials**: Any other combination will show an error.

// ### Extending the App
// - **Navigation**: After successful login, navigate to a home screen based on the user’s role.
//   ```dart
//   if (state is AuthAuthenticated) {
//     if (state.user.role == 'admin') {
//       Navigator.popAndPushNamed(context, '/admin_dashboard');
//     } else {
//       Navigator.popAndPushNamed(context, '/user_home');
//     }
//   }
//   ```
// - **API Integration**: Replace static data in `AuthBloc` with API calls.
// - **Additional Features**: Add registration, forgot password, or social login options.

// This code provides a solid foundation for a Flutter login page with a beautiful UI, form validation, and BLoC-based state management. Let me know if you need further customization or additional features!