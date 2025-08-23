import 'package:flutter/material.dart';
import 'package:dalell/app/profile_screen.dart';
import 'package:dalell/models/Usermodel.dart';
import 'package:dalell/admin/admin_page.dart';
import 'package:dalell/product/categories_page.dart';
import 'package:dalell/product/product_details.dart';
import 'package:dalell/views/login_page.dart';
import 'package:dalell/oop/responsive.dart';
import 'package:dalell/admin/tips_page.dart';
import 'package:dalell/views/profile_page.dart';
import 'package:dalell/order/orderconform.dart';
import 'package:dalell/product/product_order_page.dart';
import 'package:dalell/views/login.dart';
import 'package:dalell/views/profile_detail.dart';
import 'package:dalell/views/rest_password.dart';

const HomePages = '/HomePage';

class RouteGenerator {
  // 2.
  static const String HomePages = '/';
  static const String randomPage = '/random';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String RestPassword = '/RestPassword';
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
      case HomePages:
// .5
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
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
          builder: (_) => const BuildBodyLayou(),
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

      case RestPassword:
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
