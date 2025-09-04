import 'package:dalell/home.dart';
import 'package:dalell/marchent_page.dart';
import 'package:flutter/material.dart';
import 'package:dalell/coustomer_page.dart';
import 'package:dalell/models/Usermodel.dart';
import 'package:dalell/views/user/login_page.dart';
import 'package:dalell/oop/responsive.dart';
import 'package:dalell/views/user/profile_page.dart';
import 'package:dalell/product/view/product_editor_page.dart';
import 'package:dalell/product/view/product_order_page.dart';
import 'package:dalell/views/user/login.dart';
import 'package:dalell/views/user/profile_detail.dart';
import 'package:dalell/views/user/rest_password.dart';

// const homePages = '/HomePage';

class RouteGenerator {
  // 2.
  static const String homePages = '/';
  static const String marchentPages = '/MarchentPage';

  static const String randomPage = '/random';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String restPassword = '/RestPassword';
  static const String passwordRecoveryScreen = '/PasswordRecoveryScreen';

  static const String profileDetail = '/ProfileDetail';
  static const String loginScreen = '/LoginScreen';
  static const String loginPage = '/LoginPage';
  static const String productDetails = '/BuildBodyLayou';

  static const String categoriesPage = '/categories';
  static const String rFQPage = '/rfq';
  static const String tipsPage = '/tips';

  static const String profilePage = '/unstop';

  static const String productEditorPage = '/ProductEditorPage';
  static const String productOrderPage = '/ProductOrderPage';
// 3.
  RouteGenerator._();
  

  static Route<dynamic> generateRoute(RouteSettings settings) {
//4.
    switch (settings.name) {
      case homePages:
// .5
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
   case marchentPages:
// .5
        return MaterialPageRoute(
          builder: (_) => const MarchentPage(),
        );
        
      case randomPage:
        return MaterialPageRoute(
          builder: (_) => const ResponsiveUi(),
        );

      case productEditorPage:
        return MaterialPageRoute(
          builder: (_) => const ProductEditorPage(),
        );
      case productOrderPage:
        return MaterialPageRoute(
          builder: (_) => const ProductOrderPage(),
        );

      case productDetails:
        return MaterialPageRoute(
          builder: (_) => const ProductEditorPage(),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case profileDetail:
        return MaterialPageRoute(
          builder: (_) => const ProfileDetail(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case passwordRecoveryScreen:
        return MaterialPageRoute(
          builder: (_) => PasswordRecoveryScreen(),
        );

      case restPassword:
        return MaterialPageRoute(
          builder: (_) => const ImageWidetDeom(
            title: '',
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginPages(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case profilePage:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );

      case tipsPage:
        return MaterialPageRoute(
          builder: (_) => const TipsPage(),
        );
      case rFQPage:
        return MaterialPageRoute(
          builder: (_) => const RFQPage(),
        );
      case categoriesPage:
        return MaterialPageRoute(
          builder: (_) => const CategoriesPage(),
        );

      default:
        throw const FormatException("Route not found");
    }
  }
}

// 5.
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
