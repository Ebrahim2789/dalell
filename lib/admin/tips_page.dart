import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Following', style: TextStyle(fontSize: 16)),
                  Text('Recommended', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hot topics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150,
              
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  TopicCard(
                    imagePlaceholder: 'Selected global new products',
                    hashtag: '#Selected global new products',
                    views: '779',
                  ),
                  TopicCard(
                    imagePlaceholder: 'Find your high-quality products',
                    hashtag: '#Find your high-quality products',
                    views: '8.6k',
                  ),
                  TopicCard(
                    imagePlaceholder: 'Unique novelties',
                    hashtag: '#Unique novelties',
                    views: '25.4k',
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Get inspired',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Shoes',
              duration: '00:25',
              title: 'Fashionable appearance walk on your style#shoes #soft',
              views: '1.7k',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'What is Alibaba.com?',
              duration: '01:49',
              title: 'The official guidebook to Alibaba.com',
              views: '4.3M',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Body slimming',
              duration: '00:40',
              title: '#emsculpt #bodyshape #Body SlimmingPro',
              views: '57.7k',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Muslim dress',
              duration: '00:18',
              title: 'Muslim dress show',
              views: '',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Earphones',
              duration: '01:00',
              title: 'Pro2 gen earphones',
              views: '',
            ),
          ],
        ),
      ),
    );
  }
}


class TopicCard extends StatelessWidget {
  final String imagePlaceholder;
  final String hashtag;
  final String views;

  const TopicCard({
    super.key,
    required this.imagePlaceholder,
    required this.hashtag,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: 150,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          
          color: Colors.grey[200],
          
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: Text(imagePlaceholder)),
            ),
            Text(hashtag, style: const TextStyle(fontSize: 12)),
            Text(views, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnailPlaceholder;
  final String duration;
  final String title;
  final String views;

  const VideoCard({
    super.key,
    required this.thumbnailPlaceholder,
    required this.duration,
    required this.title,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Center(child: Text(thumbnailPlaceholder)),
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(duration, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(views, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 30,
              left: 8,
              child: Text(title, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
