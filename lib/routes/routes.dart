import 'package:dalell/cart/product_list_page.dart';
import 'package:dalell/config/theme/app_theme.dart';
import 'package:dalell/config/theme/shared_preferences_service.dart';
import 'package:dalell/config/theme/theme_repository.dart';
import 'package:dalell/home.dart';
import 'package:dalell/marchent_page.dart';
import 'package:dalell/models/tipsPage.dart';
import 'package:dalell/order/views/address_list_view.dart';
import 'package:dalell/order/views/delivery_list_view.dart';
import 'package:dalell/order/views/order_list_view.dart';
import 'package:dalell/product/view/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:dalell/coustomer_page.dart';
import 'package:dalell/models/Usermodel.dart';
import 'package:dalell/views/user/sign_in_option_page.dart';
import 'package:dalell/oop/responsive.dart';
import 'package:dalell/views/user/profile_page.dart';
import 'package:dalell/product/view/product_editor_page.dart';
import 'package:dalell/product/view/product_order_page.dart';
import 'package:dalell/views/user/login.dart';
import 'package:dalell/views/user/profile_edit.dart';
import 'package:dalell/views/user/rest_password.dart';

// const homePages = '/HomePage';

class RouteGenerator {
  // 2.
    static const String root = '/';
  static const String homePages = '/CustomerPage';
  static const String marchentPages = '/MarchentPage';

  static const String randomPage = '/random';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String restPassword = '/RestPassword';
  static const String passwordRecoveryScreen = '/PasswordRecoveryScreen';

  static const String profileDetail = '/ProfileDetail';
  static const String loginScreen = '/LoginScreen';
  static const String signInPage = '/signInPage';
  static const String productDetails = '/BuildBodyLayou';

  static const String categoriesPage = '/categories';
  static const String rFQPage = '/rfq';
  static const String tipsPage = '/tips';

  static const String profilePage = '/unstop';

  static const String productEditorPage = '/ProductEditorPage';
  static const String productOrderPage = '/ProductOrderPage';

  static const String orderPage = '/orderPage';
  static const String addressPage = '/addressPage';
  static const String deliverisPage = '/deliverisPage';
  static const String cartPage = '/cartPage';
  static const String appTheme = '/AppTheme';

// 3.
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
//4.
    switch (settings.name) {
            case root:
// .5
        return MaterialPageRoute(
          builder: (_) => const  SignInPage(),

        
        );
      case homePages:
// .5
        return MaterialPageRoute(
          builder: (_) => 

           ProfileScreen(themeRepository: ThemeRepository(
            SharedPreferencesService()
          ),),
        );
      case marchentPages:
// .5
        return MaterialPageRoute(
          builder: (_) => const MarchentPage(),
        );
      case appTheme:
// .5
        return MaterialPageRoute(
          builder: (_) => AppTheme(
            themeRepository: ThemeRepository(SharedPreferencesService()),
          ),
        );
      case orderPage:
        return MaterialPageRoute(
          builder: (_) => const OrderListView(),
        );

      case deliverisPage:
        return MaterialPageRoute(
          builder: (_) => const DeliveryListView(),
        );
      case addressPage:
        return MaterialPageRoute(
          builder: (_) => const AddressListView(),
        );
      case cartPage:
        return MaterialPageRoute(
          builder: (_) => const ProductListPage(),
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
      case signInPage:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case profilePage:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );

      case tipsPage:
        return MaterialPageRoute(
          builder: (_) => const TipsPages(),
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
