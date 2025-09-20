
import 'package:dalell/product/controller/product_controller.dart';
import 'package:flutter/material.dart';

import '../product/models/product.dart';

class TipsPages extends StatefulWidget {
  const TipsPages({super.key});

  @override
  State<TipsPages> createState() => _TipsPagesState();
}

class _TipsPagesState extends State<TipsPages> {

 final ProductController controller = ProductController();
  List<Product> products = [];

  void _loadProducts() async {
    final data = await controller.getAllProducts();

    if (data.isEmpty) {
      await controller.insertProduct(StaticData.products.first);
    }

    setState(() {
      products = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final topicCardWidth = isWide ? 220.0 : 150.0;
    final videoCardHeight = isWide ? 250.0 : 200.0;
    final horizontalPadding = isWide ? 32.0 : 16.0;
    final fontSize = isWide ? 20.0 : 16.0;
    final sectionTitleSize = isWide ? 22.0 : 18.0;
       final topics = [];
          final videos = [];


    for (var p in products) {

       topics.add(  TopicCard(
        imagePlaceholder: p.media.map((value)=>value.url).first,
        hashtag: '#${p.name}',
        views: '${p.price}',
        width: topicCardWidth,
      ));

        videos.add(    VideoCard(
        thumbnailPlaceholder: p.media.map((value)=>value.url).first,
        duration: '00:25',
        title: '#${p.name}',
        views: '${p.price}k',
        height: videoCardHeight,
      ));


    }

    // final topics = [
    //   TopicCard(
    //     imagePlaceholder: 'Selected global new products',
    //     hashtag: '#Selected global new products',
    //     views: '779',
    //     width: topicCardWidth,
    //   ),
    //   TopicCard(
    //     imagePlaceholder: 'Find your high-quality products',
    //     hashtag: '#Find your high-quality products',
    //     views: '8.6k',
    //     width: topicCardWidth,
    //   ),
    //   TopicCard(
    //     imagePlaceholder: 'Unique novelties',
    //     hashtag: '#Unique novelties',
    //     views: '25.4k',
    //     width: topicCardWidth,
    //   ),
    // ];

    // final videos = [
    //   VideoCard(
    //     thumbnailPlaceholder: 'Shoes',
    //     duration: '00:25',
    //     title: 'Fashionable appearance walk on your style#shoes #soft',
    //     views: '1.7k',
    //     height: videoCardHeight,
    //   ),
    //   VideoCard(
    //     thumbnailPlaceholder: 'What is Alibaba.com?',
    //     duration: '01:49',
    //     title: 'The official guidebook to Alibaba.com',
    //     views: '4.3M',
    //     height: videoCardHeight,
    //   ),
    //   VideoCard(
    //     thumbnailPlaceholder: 'Body slimming',
    //     duration: '00:40',
    //     title: '#emsculpt #bodyshape #Body SlimmingPro',
    //     views: '57.7k',
    //     height: videoCardHeight,
    //   ),
    //   VideoCard(
    //     thumbnailPlaceholder: 'Muslim dress',
    //     duration: '00:18',
    //     title: 'Muslim dress show',
    //     views: '',
    //     height: videoCardHeight,
    //   ),
    //   VideoCard(
    //     thumbnailPlaceholder: 'Earphones',
    //     duration: '01:00',
    //     title: 'Pro2 gen earphones',
    //     views: '',
    //     height: videoCardHeight,
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tips', style: TextStyle(fontSize: fontSize + 2)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Following', style: TextStyle(fontSize: fontSize)),
                    Text('Recommended',
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
                child: Text(
                  'Hot topics',
                  style: TextStyle(
                      fontSize: sectionTitleSize, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: topicCardWidth + 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topics.length,
                  itemBuilder: (context, index) => topics[index],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
                child: Text(
                  'Get inspired',
                  style: TextStyle(
                      fontSize: sectionTitleSize, fontWeight: FontWeight.bold),
                ),
              ),
              // Responsive video cards: grid for wide, column for narrow
              isWide
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: videos.length,
                      itemBuilder: (context, index) => videos[index],
                    )
                  : Column(
                      children: [...videos,]
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update TopicCard and VideoCard to accept width/height for responsiveness:

class TopicCard extends StatelessWidget {
  final String imagePlaceholder;
  final String hashtag;
  final String views;
  final double width;

  const TopicCard({
    super.key,
    required this.imagePlaceholder,
    required this.hashtag,
    required this.views,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: Image.asset(imagePlaceholder)),
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
  final double height;

  const VideoCard({
    super.key,
    required this.thumbnailPlaceholder,
    required this.duration,
    required this.title,
    required this.views,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
               Center(child: Image.asset(thumbnailPlaceholder)),
      
            Positioned(
              bottom: 8,
              left: 8,
              child:
                  Text(duration, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(views, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 30,
              left: 8,
              right: 8,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}