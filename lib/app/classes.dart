// class Name{
//   final String first;
//   final String last;
//   Name(this.first,this.last);
//   @override
//   String toString() {

//     return '$first $last';
//   }
// }
// class OfficalName extends Name{
//   final String _title;
//   OfficalName(this._title,String first, String last):super(first,last);
//   @override
//   String toString() {
//     // TODO: implement toString
//     return '$_title. ${super.toString()}';
//   }

// }


// void play(){
//   final name=OfficalName('marl', 'ali', 'aka');
//   final message=name.toString();
//   print(message);
// }


// class UrlBuilder{
//   String? _scheme;
//   String? _host;
//   String? _path;
//   UrlBuilder setScheme(String value){
//     _scheme=value;
//     return this;
//   }
// UrlBuilder setPath(String value){
//   _path=value;
//   return this;
// }
// UrlBuilder setHost(String value){
//   _host=value;
//   return this;
// }

// String build(){
//   assert(_scheme!=null);
//   assert(_host!=null);
//   assert(_path!=null);
//   return '$_scheme://$_host/$_path';
// }

// }

// void urlbuild(){
//   final url=UrlBuilder()
//   .setScheme('https')
//   .setHost('dart.dev')
//   .setPath('/gus/sf/sds')
//   .build();
//   print(url);
// }

// class RouteBuilder{
//   String scheme='';
//   String host='';
//   List<String> routes =[];
//   @override
//   String toString() {


// final paths=[host, if(routes!=[])...routes];
// final path=paths.join('/');

//     return '$scheme://$path';
//   }
// }
// void cascadePlay(){
//   final url=RouteBuilder()
//   ..scheme='https'
//   ..host='dart.dev'
//   ..routes=[
// 'guides',
// 'language',
// 'tools'
//   ];
//   print(url);

//   final numbers=[32,45,52,25,]
//   ..insert(0, 8)
//   ..sort((a,b)=>a.compareTo(b));
//   print(numbers.last);
// }


// // using extention

// extension StringExtention on String{
//   bool toBool(){
//     return isNotEmpty;
//   }
// }

// void testExtention(){
//   String emptyString="";
//   String notEmptyString="hello extention";
//   print(emptyString.toBool());
//   print(notEmptyString.toBool());
// }



// void increaseNumber(int? value){
//   value=value??0;
//   value++;
//   print(value);
// }

// class Person {
//  late String name;
//  late String surename;
// late int age;
//   Person(this.name,this.surename,{ required this.age});


// Person.fromMap(Map<String,dynamic> map){
// name=map['name'];
// surename=map['surename'];
// age=map['age'];
// }
// }

// void main(){
// // play();
// // urlbuild();
// // cascadePlay();
// testExtention();
// int? somevalue;
// increaseNumber(somevalue);
// var bruce=Person('bruc', 'waye',age:34);
// if(bruce.age<18){
//   print('minuer');
// }

// Person? person;
// print(person?.name);


// // ??
// // ?. 
// List<String> array=['ali','jjhh'];

// // ??=
// // ..
// final  p=Point()
// ..x=6
// ..y=4
// ..build();

// print(p);

// }

// class Point{
// late int x;
// late int y;
// // Point(this.x,this.y);
// @override
// String toString(){
//   return "$x $y";
// }
// String build(){
//     return "$x $y";
// }

// }