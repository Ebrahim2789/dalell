import 'package:flutter/material.dart';

class TextWidgetDemo extends StatefulWidget {
  const TextWidgetDemo({super.key});

  @override
  State<TextWidgetDemo> createState() => _TextWidgetDemoState();
}

class _TextWidgetDemoState extends State<TextWidgetDemo> {
    final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    
     Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
          ),
          TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                label: const Text("Enter your email"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email_outlined)),
          ),
       const Padding(padding: EdgeInsets.all(8)),
          TextFormField(
            controller: passwordcontroller,
            keyboardType: TextInputType.visiblePassword,
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
                label: const Text("enter you password"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.lock)),
          ),
                   const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
              onPressed: () {
                final email = emailcontroller.text;
                final password = passwordcontroller.text;
                if (email == 'abre' && password == 'pass') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login succeful')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed')));
                }
              },
              
              child: const Text("login"))
              
        ],
        
      ),
    );
  }
}

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
       Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        TextField(
          controller: emailcontroller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              label: const Text("Enter your email"),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.email_outlined)),
        ),
        const SizedBox(
          width: 8.3,
          height: 4.3,
        ),
        TextFormField(
          controller: passwordcontroller,
          keyboardType: TextInputType.visiblePassword,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
              label: const Text("enter you password"),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.lock)),
        ),
          const SizedBox(
          width: 8.3,
          height: 4.3,
        ),
        ElevatedButton(
            onPressed: () {
              final email = emailcontroller.text;
              final password = passwordcontroller.text;
              if (email == 'abre' && password == 'pass') {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login succeful')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed')));
              }
            },
            
            child: const Text("login"))
      ],
    ));
  }
}

class TextRichDemo extends StatefulWidget {
  const TextRichDemo({super.key});

  @override
  State<TextRichDemo> createState() => _TextRichDemoState();
}

class _TextRichDemoState extends State<TextRichDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
            text: 'Hello world ',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24.7,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
              decorationStyle: TextDecorationStyle.solid,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
            ),
            children: <TextSpan>[
              TextSpan(text: 'for', style: TextStyle(color: Colors.red)),
              TextSpan(
                  text: 'Mobile',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ))
            ]),
      ),
    );
  }
}
