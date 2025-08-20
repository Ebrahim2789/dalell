// _buildJournalHeaderImage(),
// _buildJournalEntry(),
//_buildJournalWeather(),
//_buildJournalTags(),
// _buildJournal-
// FooterImages()

import 'package:flutter/material.dart';
import 'package:dalell/app/star.dart';
import 'package:dalell/routes.dart';

class BuildBodyLayou extends StatelessWidget {
  const BuildBodyLayou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Complex Layout',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightBlue,

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),

          iconTheme: const IconThemeData(color: Colors.black),
          // brightness: Brightness.light,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.cloud_queue))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/image2.jpg",
                          fit: BoxFit.cover),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text("Transfer to Balance"),
                    onPressed: () {

                      Navigator.of(context).pushNamed(RouteGenerator.productOrderPage);
                    },
                  ),
                ],
              )),
              const StarRating(
                color: Colors.yellow,
                value: 5,
              ),

              _buildJournalEntry(),
              const Divider(),
              _buildJournalWeather(),
              const Divider(),
              _buildJournalTags(),
              // const Divider(),
              _buildJournalFooterImages(),
            ],
          ),
        ));
  }
}

Row _buildJournalFooterImages() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage('assets/images/iphone.png'),
      ),
      CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage('assets/images/pixel.png'),
      ),
      CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage('assets/images/iphone.png'),
      ),
      SizedBox(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.cake),
            Icon(Icons.star_border),
            Icon(Icons.music_note)
          ],
        ),
      )
    ],
  );
}

// Create the _buildJournalEntry() method, which returns a Column. The Column children list of
// widgets contains two Text widgets and one Divider() widget.

// Create the _buildJournalWeather() method, which returns a Row. The Row children list of
// widgets contains a Column, a SizedBox, and another Column. The second Column list of widgets
// contains two Row widgets

Row _buildJournalWeather() {
  return const Row(
    children: [
      Wrap(
        children: [
          Icon(
            Icons.star,
            color: Colors.orange,
          )
        ],
      ),
    ],
  );
}

Wrap _buildJournalTags() {
  return Wrap(
    spacing: 8.0,
    children: List.generate(9, (int index) {
      return Chip(
        label: Text(
          'Gift ${index + 1}',
          style: const TextStyle(fontSize: 10.0),
        ),
        avatar: Icon(
          Icons.card_giftcard,
          color: Colors.blue.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.grey.shade100,
      );
    }),
  );
}

Column _buildJournalEntry() {
  return const Column(
    children: [
      Text(
        '81o Clear',
        style: TextStyle(color: Colors.deepOrange),
      ),
      Divider(),
      Text(
        '4500 San Alpho Drive, Dallas, TX United States',
        style: TextStyle(
          color: Colors.grey,
          overflow: TextOverflow.fade,
        ),
      ),
      Text(
        'My BirthDay',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      Divider(),
      Text(
        'It’s going to be a great birthday. We are going out for dinner at my favorite place, then watch a movie after we go to the gelateria for ice cream and espresso.',
        style: TextStyle(color: Colors.black),
      ),
    ],
  );
}
