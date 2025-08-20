import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LuckyDrawPage extends StatelessWidget {
  const LuckyDrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'affle',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        
        child: Column(
          
          children: [
            
            // Header
            Container(
              color: Colors.orange,
          
                margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Prizes', style: TextStyle(color: Colors.white, fontSize: 18)),
                      Text('Record', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Draw a lottery or raffle',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Prize Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildPrizeBox('Br 30', Icons.monetization_on),
                  _buildPrizeBox('Br 80', Icons.monetization_on),
                  _buildPrizeBox('iPad', Icons.tablet_mac),
                  _buildPrizeBox('Br 600', Icons.monetization_on),
                  _buildDrawBox(),
                  _buildPrizeBox('Br 1000', Icons.monetization_on),
                  _buildPrizeBox('Br 2000', Icons.monetization_on),
                  _buildPrizeBox('Br 3500', Icons.monetization_on),
                  _buildPrizeBox('Br 5000', Icons.monetization_on),
                ],
              ),
            ),
            // Records Table
            Container(
              color: Colors.orange,
             
                margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User', style: TextStyle(color: Colors.white)),
                      Text('Data', style: TextStyle(color: Colors.white)),
                      Text('Reward', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Divider(color: Colors.white),
                  _buildRecordRow('****547', '08-14 13:05:13', 'Br 5000'),
                  _buildRecordRow('****285', '08-14 11:18:03', 'Br 30'),
                  _buildRecordRow('****752', '08-14 11:13:17', 'Br 80'),
                  _buildRecordRow('****806', '08-14 11:09:04', 'Br 5000'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrizeBox(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Icon(icon, size: 40, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildDrawBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Number of draws'),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordRow(String user, String data, String reward) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(user, style: const TextStyle(color: Colors.white)),
        Text(data, style: const TextStyle(color: Colors.white)),
        Text(reward, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
