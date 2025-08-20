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
