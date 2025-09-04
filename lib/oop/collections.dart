// void main() {
//   collectionsPlayGround();
// }

// void collectionsPlayGround() {
//   // listPlay();
//   // mapPlay();
//   // setPlay();
//   // collectionsControlFlow();
//   higherOrderFunction();
// }

// void higherOrderFunction() {
//   // final name = mapping();
//   // name.forEach(print);
//   // sorting();
//   // filtering();
//   reducing();
//   faltting();
// }

// List<Map> data = [
//   {'first': 'adami', 'last': 'amhaed', 'age': 34},
//   {'first': 'kado', 'last': 'amhaed', 'age': 44},
//   {'first': 'lolo', 'last': 'amhaed', 'age': 54},
//   {'first': 'uso', 'last': 'kadli', 'age': 14},
//   {'first': 'bani', 'last': 'amhaed', 'age': 30},
// ];

// class Name {
//   final String first;
//   final String last;
//   final int age;
//   Name(this.first, this.last, this.age);
//   @override
//   String toString() {
//     return "$first $last $age";
//   }
// }

// List<Name> mapping() {
//   final names = data.map<Name>((Map raw) {
//     final first = raw['first'];
//     final last = raw['last'];
//     final age = raw['age'];
//     return Name(first, last, age);
//   }).toList();
//   // return names;

//   final nam = data
//       .map<Name>((raw) => Name(
//             raw['first'],
//             raw['last'],
//             raw['age'],
//           ))
//       .toList();
// // return nam;

//   final namesa = <Name>[];
//   for (Map raw in data) {
//     final first = raw['first'];
//     final last = raw['last'];
//     final age = raw['age'];
//     final Nam = Name(first, last, age);
//     namesa.add(Nam);
//   }
//   return namesa;
// }

// void sorting() {
//   final names = mapping();
//   // names.sort((a, b) => a.first.compareTo(b.first));
//   names.sort((a, b) {
//     return a.last.compareTo(b.last);
//   });

//   names.forEach(print);
// }

// void filtering() {
//   final names = mapping();
//   final lastA = names.where((name) => name.last.startsWith('ah'));
//   lastA.forEach(print);
// }

// void reducing() {
//   final allAges = data.map<int>((person) => person['age']);
//   // final total = allAges.reduce((total, age) => (total + age));
//   final addTotal = allAges.fold(35, (total, age) => (total + age));
//   // final avaarege = total / allAges.length;
//   allAges.forEach(print);
//   print(addTotal);
// }

// void faltting() {
//   final matrix = [
//     [2, 3, 4],
//     [6.7, 4],
//     [5, 1, 2]
//   ];
//   print(matrix);

//   final linear = matrix.expand<num>((row) => row);
//   print(linear);
// }

// void collectionsControlFlow() {
//   const addMore = true;
//   final collections = [
//     122,
//     34,
//     45.6,
//     8,
//     9,
//     55,
//     3,
//     3,
//     3,
//     221,
//     2,
//     34,
//     if (addMore) ...[
//       74,
//       56,
//       77,
//     ]
//   ];
//   // collections.forEach(print);

//   for (var number in collections) {
//     print(number * 2);
//   }
// }

// void setPlay() {
//   final Set<String> names = {'adame', 'matan', 'jamel'};
//   final isAdam = names.contains('adame');
//   print(isAdam);
//   names.forEach(print);
// }

// void mapPlay() {
//   final Map<String, int> ages = {'ali': 43, 'lall': 32, 'looo': 24};

//   ages['peter'] = 67;
//   final peterAge = ages['peter'];
//   print(peterAge);

//   ages.forEach((String name, int age) {
//     print('$name is $age years older');
//   });
// }

// void listPlay() {
//   final List<int> number = [1, 2, 3, 4, 5];
//   final List<int> list2 = [
//     0,
//     98,
//   ];
//   number.add(7);

//   number.addAll([9, 0, 4]);
//   number.addAll(list2);
//   number.remove(4);
//   number.removeAt(2);
//   number.reversed;
//   number.forEach(print);
// }

// String duplicate(String name, {int times = 1}) {
//   final merged = StringBuffer(name);
//   for (var i = 1; i < times; i++) {
//     merged.write(' $name');
//   }
//   return merged.toString();
// }







// import 'dart:convert';

// void main() {

//   consumeClosure();
//   printSwitch();
//   recordes();
//   classPlayground();
// }

// void callBackExample(void Function(String value) callback) {
//   callback('hello callback');
// }

// typedef NumberGetter = int Function();

// int powerOfTwo(NumberGetter getter) {
//   return getter() * getter();
// }

// void printSomething(String value) {
//   print(value);
// }

// void consumeClosure() {
//   int getFour() => 4;
//   final squred = powerOfTwo(getFour);
//   print(squred);
//   callBackExample(printSomething);
// }

// void printSwitch() {
//   int dayOfWeek = 7;
// var mayDay=switch(dayOfWeek){
//   1=>'monday',
//   2=>'tuesday',
//   _=>'sunday',
// };
// print(mayDay);
// }


// // records
// void recordes(){
//   // var person=(name:'abre',age:43);
// ({int a,int b}) add=(a:2,b:5);
//   print(add.a);
// var(String name,int age)=getPerson({'name':'abadalla','age':32});
// print('${name} is ${age} olds');

// }
// (String,int)getPerson(Map<String,dynamic>json){
//   return(json['name']as String ,json['age']as int);
// }

// class Name{
// final String first;
// final String last;
// Name(this.first,this.last);
// @override
//   String toString() {

//     return '$first,$last';
//   }
// }
// class OfficalName extends Name{
//   final String _title;
//   OfficalName(this._title,String first,String last):super(first,last);
//   @override
//   String toString() {
//  return '$_title $first,$last';
//   }

// }
// void classPlayground() {
// final name = OfficalName('Mr', 'Clark', 'Kent');

// final message = name.toString();
// print(message);

// final supern=Name("first", 'ali');
// print(supern.toString());
// }





// import 'package:flutter/material.dart';
// import 'package:dalell/pathdemo.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Bottom AppBar Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const CustomerScreen(),
//     const MerchantScreen(),
//     const HomeScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_currentIndex == 0
//             ? 'Customer'
//             : _currentIndex == 1
//                 ? 'Merchant'
//                 : 'Home'),
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 0;
//                 });
//               },
//               color: _currentIndex == 0 ? Colors.blue : Colors.grey,
//             ),
//             IconButton(
//               icon: const Icon(Icons.store),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 1;
//                 });
//               },
//               color: _currentIndex == 1 ? Colors.blue : Colors.grey,
//             ),
//             IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 2;
//                 });
//               },
//               color: _currentIndex == 2 ? Colors.blue : Colors.grey,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _currentIndex = 2; // Navigate to Home on FAB click
//           });
//         },
//         child: const Icon(Icons.home),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// class CustomerScreen extends StatelessWidget {
//   const CustomerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Customer Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class MerchantScreen extends StatelessWidget {
//   const MerchantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Merchant Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }




class RainbowIterator implements Iterator {
  final _colors = [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Indigo",
    "Violet"
  ];
  var _index = 0;
  @override
  String get current => _colors[_index++];
  @override
  bool moveNext() => _index < _colors.length;
}

// void main() {
//   var rainbowColors = RainbowIterator();
//   while (rainbowColors.moveNext()) {
//     print(rainbowColors.current);
//   }

  /*
    Red
    Orange
    Yellow
    Green
    Blue
    Indigo
    Violet
  */
// }



abstract class Receiver {
  Set<String> get actions;
}

abstract class Command {
  late Receiver receiver;
  late String name;

  Command(this.receiver);

  @override
  String toString() => name;

  void execute();
}

class Invoker {
  List<String> history = [];
  void execute(Command cmd) {
    cmd.execute();
    history.add("[${DateTime.now()}] Executed $cmd");
  }

  @override
  String toString() =>
      history.fold("", (events, event) => "$events$event\r\n");
}

class TurnOffCommand extends Command {
  @override
  String name = "Turn off";
  TurnOffCommand(Light super.light);
  @override
  void execute() {
    (receiver as Light).turnOff();
  }
}

class TurnOnCommand extends Command {
  @override
  String name = "Turn on";
  TurnOnCommand(Light super.light);
  @override
  void execute() {
    (receiver as Light).turnOn();
  }
}

class Light implements Receiver {
  void turnOff() => print("Light off!");
  void turnOn() => print("Light on!");
  @override
  Set<String> get actions => {"off", "on"};
}

class LightSwitch {
  final Invoker _switch = Invoker();
  Light light;

  LightSwitch(this.light);

  String get history => _switch.toString();

  void perform(String action) {
    if (!light.actions.contains(action)) {
      return print("Uh...wait, wut?");
    }
    switch (action) {
      case "on":
        return _switch.execute(TurnOnCommand(light));
      case "off":
        return _switch.execute(TurnOffCommand(light));
    }
  }
}

// void main() {
//   var myFavoriteLamp = Light();
//   var iotLightSwitch = LightSwitch(myFavoriteLamp);

//   iotLightSwitch.perform("on");
//   iotLightSwitch.perform("off");
//   iotLightSwitch.perform("blink");
//   iotLightSwitch.perform("on");

//   print("\r\n*** Fancy IoT Switch Logs ***\r\n${iotLightSwitch.history}");

//   /*
//     Light on!
//     Light off!
//     Uh...wait, wut?
//     Light on!

//     *** Fancy IoT Switch Logs ***
//     [2019-06-20 08:00:38.880050] Executed Turn on
//     [2019-06-20 08:00:38.883495] Executed Turn off
//     [2019-06-20 08:00:38.883702] Executed Turn on
//   */
// }


class Notification {
  late String message;
  late DateTime timestamp;
  Notification(this.message, this.timestamp);
  Notification.forNow(this.message) {
    timestamp = DateTime.now();
  }
}

class Observable {
  late List<Observer> _observers;

  Observable([List<Observer>? observers]) {
    _observers = observers ?? [];
  }

  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  void notify_observers(Notification notification) {
    for (var observer in _observers) {
      observer.notify(notification);
    }
  }
}

class Observer {
  late String name;

  Observer(this.name);

  void notify(Notification notification) {
    print(
        "[${notification.timestamp.toIso8601String()}] Hey $name, ${notification.message}!");
  }
}

class CoffeeMaker extends Observable {
  CoffeeMaker([super.observers]);
  void brew() {
    print("Brewing the coffee...");
    notify_observers(Notification.forNow("coffee's done"));
  }
}

// void main() {
//   var me = Observer("Tyler");
//   var mrCoffee = CoffeeMaker(List.from([me]));
//   var myWife = Observer("Kate");
//   mrCoffee.registerObserver(myWife);
//   mrCoffee.brew();
//   /*
//     Brewing the coffee...
//     [2019-06-18T07:30:04.397518] Hey Tyler, coffee's done!
//     [2019-06-18T07:30:04.397518] Hey Kate, coffee's done!
//   */
// }


abstract class State {
  void handler(Stateful context);
  @override
  String toString();
}

class StatusOn implements State {
  @override
  handler(Stateful context) {
    print("  Handler of StatusOn is being called!");
    context.state = StatusOff();
  }

  @override
  String toString() {
    return "on";
  }
}

class StatusOff implements State {
  @override
  handler(Stateful context) {
    print("  Handler of StatusOff is being called!");
    context.state = StatusOn();
  }

  @override
  String toString() {
    return "off";
  }
}

class Stateful {
  State _state;

  Stateful(this._state);

  State get state => _state;
  set state(State newState) => _state = newState;

  void touch() {
    print("  Touching the Stateful...");
    _state.handler(this);
  }
}

// void main() {
//   var lightSwitch = Stateful(StatusOff());
//   print("The light switch is ${lightSwitch.state}.");
//   print("Toggling the light switch...");
//   lightSwitch.touch();
//   print("The light switch is ${lightSwitch.state}.");
// }


abstract class Thing {
  late String name;
  void doSomething();
}

class CompositeThing implements Thing {
  @override
  String name;
  final Set<Thing> _childThings = {};

  CompositeThing(this.name);

  void addChild(Thing child) {
    _childThings.add(child);
  }

  @override
  void doSomething() {
    print("\r\n** $name is doing something! ** \r\n");
    for (var thing in _childThings) {
      thing.doSomething();
    }
    print("\r\n** $name is all done. ** \r\n");
  }
}

class LeafThing implements Thing {
  @override
  String name;

  LeafThing(this.name);

  @override
  void doSomething() {
    print("*  $name!");
  }
}

void main() {
  var compositeParent = CompositeThing("Cat in the Hat");
  var compositeChild1 = CompositeThing("Thing 1");
  var compositeChild2 = CompositeThing("Thing 2");

  var leaf1_1 = LeafThing("Frustrate fish");
  var leaf1_2 = LeafThing("Knock down vases");
  var leaf2_1 = LeafThing("Ruin mom's dress");
  var leaf2_2 = LeafThing("Clean up");

  compositeChild1.addChild(leaf1_1);
  compositeChild1.addChild(leaf1_2);

  compositeChild2.addChild(leaf2_1);
  compositeChild2.addChild(leaf2_2);

  compositeParent.addChild(compositeChild1);
  compositeParent.addChild(compositeChild2);

  compositeParent.doSomething();

  /*
   ** Cat in the Hat is doing something! **


    ** Thing 1 is doing something! **

    *  Frustrate fish!
    *  Knock down vases!

    ** Thing 1 is all done. **


    ** Thing 2 is doing something! **

    *  Ruin mom's dress!
    *  Clean up!

    ** Thing 2 is all done. **


    ** Cat in the Hat is all done. **
  */
}