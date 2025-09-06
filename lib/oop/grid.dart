import 'package:flutter/material.dart';

class GridIcons {
  List<IconData> iconList = [];
  List<IconData> getIconList() {
    iconList
      ..add(Icons.free_breakfast)
      ..add(Icons.access_alarms)
      ..add(Icons.directions_car)
      ..add(Icons.flight)
      ..add(Icons.cake)
      ..add(Icons.card_giftcard)
      ..add(Icons.change_history)
      ..add(Icons.face)
      ..add(Icons.star)
      ..add(Icons.headset_mic)
      ..add(Icons.directions_walk)
      ..add(Icons.sentiment_satisfied)
      ..add(Icons.cloud_queue)
      ..add(Icons.exposure)
      ..add(Icons.gps_not_fixed)
      ..add(Icons.child_friendly)
      ..add(Icons.child_care)
      ..add(Icons.edit_location)
      ..add(Icons.event_seat)
      ..add(Icons.lightbulb_outline);
    return iconList;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GridViewBuilderWidget(),
    );
  }
}

class CustomScrollViews extends StatefulWidget {
  const CustomScrollViews({super.key});

  @override
  State<CustomScrollViews> createState() => _CustomScrollViewsState();
}

class _CustomScrollViewsState extends State<CustomScrollViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomScrollView - Slivers'),
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBarWidget(),
          const SliverListWidget(),
          const SliverGridWidget(),
        ],
      ),
    );
  }
}

class SliverGridWidget extends StatelessWidget {
  const SliverGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.child_friendly,
                    size: 48.0,
                    color: Colors.amber,
                  ),
                  Divider(),
                  Text('Grid ${index + 1}'),
                ],
              ),
            );
          },
          childCount: 12,
        ),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}

class SliverListWidget extends StatelessWidget {
  const SliverListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
              child: Text("${index + 1}"),
            ),
            title: Text('Row ${index + 1}'),
            subtitle: Text('Subtitle Row ${index + 1}'),
            trailing: Icon(Icons.star_border),
          );
        }),
      ),
    );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.brown,
      forceElevated: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Parallax Effect',
        ),
        background: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = GridIcons().getIconList();
    return GridView.builder(
      itemCount: 20,
      padding: EdgeInsets.all(8.0),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.lightGreen.shade50,
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconList[index],
                  size: 48.0,
                  color: Colors.lightGreen,
                ),
                Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      },
    );
  }
}

class GridCountCustom extends StatelessWidget {
  const GridCountCustom({super.key});

  @override
  Widget build(BuildContext context) {

  List<IconData> iconList = GridIcons().getIconList();
  return GridView.count(
    crossAxisCount: 3,
    padding: EdgeInsets.all(8.0),
    children: List.generate(
      7000,
      (index) {
        print('_buildGridView $index');
        return Card(
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconList[0],
                  size: 48.0,
                  color: Colors.blue,
                ),
                Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      },
    ),
  );
}
}

class GridExtentCustom extends StatelessWidget {
  const GridExtentCustom({super.key});

  @override
  Widget build(BuildContext context) {
   
  List<IconData> iconList = GridIcons().getIconList();
  return GridView.extent(
    maxCrossAxisExtent: 175.0,
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.all(8.0),
    children: List.generate(20, (index) {
      print('_buildGridViewExtent $index');
      return Card(
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconList[index],
                size: 48.0,
                color: Colors.blue,
              ),
              Divider(),
              Text(
                'Index $index',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )
            ],
          ),
          onTap: () {
            print('Row $index');
          },
        ),
      );
    }),
  );
}
}
