import 'package:flutter/material.dart';
import 'package:dalell/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MePage(),
    );
  }
}

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'personal',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child:
                          // Icon(Icons.person, color: Colors.white, size: 40),
                          IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteGenerator.profilePage,
                          );
                        },
                        icon: const Icon(Icons.person,
                            color: Colors.white, size: 40),
                      )),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('251****20313',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('UID: 105869',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text('VIP: 0',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Financial Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Total Recharge', '0.00'),
                  _buildStatCard('Total Income', '40.00'),
                  _buildStatCard('Total Withdraw', '0.00'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Team Income', '0.00'),
                  _buildStatCard('Team Size', '0'),
                  _buildStatCard('Today Income', '0.00'),
                ],
              ),
              const SizedBox(height: 20),
              // Wallet Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[400]!, Colors.orange[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.account_balance_wallet,
                        color: Colors.white, size: 30),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Wallet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('Balance wallet',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14)),
                        Text('40.00',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Personal Services
              const Text('Personal Services',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildServiceItem('My orders', Icons.reorder, context),
              _buildServiceItem('Redeem code', Icons.redeem, context),
              _buildServiceItem('Invite link', Icons.person_add, context),
              _buildServiceItem('Change Password', Icons.lock, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildServiceItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => (title) {
        if (title == "My orders") {
          Navigator.of(context).pushNamed(
            RouteGenerator.HomePages,
          );
        } else if (title == "Redeem code") {
          Navigator.of(context).pushNamed(
            RouteGenerator.passwordRecoveryScreen,
          );
        } else if (title == "Change Password") {
          Navigator.of(context).pushNamed(
            RouteGenerator.RestPassword,
          );
        } else {
          Navigator.of(context).pushNamed(
            RouteGenerator.loginScreen,
          );
        }
      }(title),
    );
  }
}
