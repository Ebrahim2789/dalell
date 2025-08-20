import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'team',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Team', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              // Added today
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[100]!, Colors.blue[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Added today', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Text('0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  _buildStatBox('Team', '0'),
                  _buildStatBox('Valid Team', '0'),
                ],
              ),
              const SizedBox(height: 24),
              // Team Registration
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.black),
                title: const Text('Team Registration'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(Icons.pie_chart, '0\nPerson', Colors.orange),
                  _buildCategoryBox(const Text('B'), '0\nPerson', Colors.pink[50]!),
                  _buildCategoryBox(const Text('C'), '0\nPerson', Colors.pink[50]!),
                  _buildCategoryBox(const Text('D'), '0\nPerson', Colors.pink[50]!),
                ],
              ),
              const SizedBox(height: 24),
              // Team Assets
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.attach_money, color: Colors.white, size: 16),
                ),
                title: const Text('Team Assets'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(Icons.pie_chart, '0\nTeam assets', Colors.blue),
                  _buildCategoryBox(const Text('B'), '0\nAsset', Colors.blue[50]!),
                  _buildCategoryBox(const Text('C'), '0\nAsset', Colors.blue[50]!),
                  _buildCategoryBox(const Text('D'), '0\nAsset', Colors.blue[50]!),
                ],
              ),
              const SizedBox(height: 24),
              // Team Investment Number
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.trending_up, color: Colors.white, size: 16),
                ),
                title: const Text('Team Investment Number'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryBox(Icons.pie_chart, '0', Colors.teal),
                  _buildCategoryBox(const Text('B'), '0', Colors.teal[50]!),
                  _buildCategoryBox(const Text('C'), '0', Colors.teal[50]!),
                  _buildCategoryBox(const Text('D'), '0', Colors.teal[50]!),
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

  Widget _buildCategoryBox(dynamic icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (icon is IconData) Icon(icon, color: color) else icon,
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
