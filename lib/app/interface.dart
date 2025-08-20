import 'package:flutter/material.dart';

class Beautful extends StatelessWidget {
  const Beautful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
             mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recomanded'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('formal ware'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('cusual weare'),
                  ],
                ),
              ],
            ),
          ),
                 const Padding(padding: EdgeInsets.all(9.0)),
          Row(

            children: [
  const SizedBox(
                width: 20,
              ),
           
                 Image.asset('assets/images/image.png',height: 200,),
              
            ],
          ),
                 const Padding(padding: EdgeInsets.all(9.0)),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 150,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Best seller',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 35,
                      fontFamily: 'PlaywriteCOGuides'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    width: 150,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 110, 107, 98),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Dail quilty',
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 35,
                          fontFamily: 'PlaywriteCOGuides'),
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.all(9.0)),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 150,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 7, 172),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Important Featuer',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 35,
                      fontFamily: 'PlaywriteCOGuides'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    width: 150,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 7, 11, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Fantastic Beatuful',
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 35,
                          fontFamily: 'PlaywriteCOGuides'),
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Row(
            children: [
              Image.asset(
                'assets/images/dog.jpg',
                width: 200,
                height: 200,
              ),
              // const Padding(padding: EdgeInsets.all(8.0)),
              const SizedBox(
                width: 100,
                
                child: Text(
                  "Flutter is Google's SDK for crafting beautiful, fast user experiences for mobile, web, and desktop from a single codebase",
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
