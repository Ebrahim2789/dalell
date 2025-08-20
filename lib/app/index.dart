import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List _page = [const HomePage(), const Marchent(), const Customer()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_currentIndex == 0
              ? 'Customer'
              : _currentIndex == 1
                  ? 'Merchant'
                  : 'Home'),
          backgroundColor: Colors.blue,
        ),
        drawer: newMethod(),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  icon: const Icon(Icons.dashboard_customize)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                  icon: const Icon(Icons.login_outlined)),
            ],
          ),
        ),
        body: _page[_currentIndex]
        //  _pageBody(emailcontroller, passwordcontroller),
        );
  }

  Drawer newMethod() {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                // backgroundImage: AssetImage(),
                ),
            ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("bookmark"),
              leading: Icon(Icons.bookmark),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image.png',
              fit: BoxFit.fitWidth,
            ),
            const Text(
              "hello marchent 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at mauris massa. Suspendisse potenti. Aenean aliquet eu nisl vitae tempus.'",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            RichText(
              text: const TextSpan(
                text: 'Flutter text is ',
                style: TextStyle(fontSize: 22, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'really ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: 'powerful.',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Marchent extends StatefulWidget {
  const Marchent({super.key});

  @override
  State<Marchent> createState() => _MarchentState();
}

class _MarchentState extends State<Marchent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image.png',
              fit: BoxFit.fitWidth,
            ),
            const Text(
              "hello marchent 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at mauris massa. Suspendisse potenti. Aenean aliquet eu nisl vitae tempus.'",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            RichText(
              text: const TextSpan(
                text: 'Flutter text is ',
                style: TextStyle(fontSize: 22, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'really ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: 'powerful.',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
    return Column(
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
    );
  }
}
