import 'package:dalell/container/container.dart';
import 'package:dalell/order/views/address_list_view.dart';
import 'package:dalell/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Setting',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              containerWithConstaran(
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Added today', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Text('0',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Stats rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBox('Invitation', '0'),
                  _buildStatBox('Valid Invitation', '0'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatBox('Team        ', '0'),
                  _buildStatBox('Valid Team   ', '0'),
                ],
              ),
              const SizedBox(height: 24),
              // Team Registration
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.black),
                title: const Text('Setting for All service'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(
                      Icons.settings, 'Setting', Colors.white, context,RouteGenerator),
                  _buildCategoryBox(
                      Icons.dark_mode, 'Themes', Colors.pink[50]!, context,RouteGenerator.appTheme),
                  _buildCategoryBox(
                      Icons.language, 'Language', Colors.pink[50]!, context,RouteGenerator),
                  _buildCategoryBox(Icons.toggle_on_sharp, 'Tools',
                      Colors.pink[50]!, context,RouteGenerator),
                ],
              ),
              const SizedBox(height: 24),
              // Team Assets
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child:
                      Icon(Icons.attach_money, color: Colors.white, size: 16),
                ),
                title: const Text('Product Assets'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(
                      Icons.shopping_bag, 'My Order', Colors.blue, context,RouteGenerator.orderPage),
                  _buildCategoryBox(Icons.delivery_dining, 'Delivery',
                      Colors.blue[50]!, context,RouteGenerator.deliverisPage),
                  _buildCategoryBox(Icons.location_city, 'Address',
                      Colors.blue[50]!, context,RouteGenerator.addressPage),
                  _buildCategoryBox(Icons.production_quantity_limits_rounded,
                      'Product', Colors.blue[50]!, context,RouteGenerator.cartPage),
                ],
              ),
              const SizedBox(height: 24),
              // Team Investment Number
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.trending_up, color: Colors.white, size: 16),
                ),
                title: const Text('Suppliers and Statistic '),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(Icons.home_max_outlined, 'DashBoard', Colors.teal, context,RouteGenerator),
                  _buildCategoryBox(
                    Icons.reviews_outlined, 'Review', Colors.teal[50]!, context,RouteGenerator),
                  _buildCategoryBox(
                      Icons.delivery_dining_sharp, 'Suppliers', Colors.teal[50]!, context,RouteGenerator),
                  _buildCategoryBox(
                      Icons.data_usage, 'Statistics', Colors.teal[50]!, context,RouteGenerator),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$title $value', style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildCategoryBox(
      dynamic icon, String label, Color color, context,  PageRoute ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (icon is IconData) Icon(icon, color: color) else icon,
          TextButton(
            onPressed: () {
            
             Navigator.of(context)
                    .pushNamed(PageRoute);

            },
            child: Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
