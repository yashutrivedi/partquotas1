import 'package:flutter/material.dart';

import 'regesterationpage.dart';

class Client_setting extends StatefulWidget {
  const Client_setting({super.key});

  @override
  State<Client_setting> createState() => _Client_settingState();
}

class _Client_settingState extends State<Client_setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting page'),
      ),
      body: Column(
        children: [
          Center(
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => RegistrationPage())));
              },
            ),
          )
        ],
      ),
    );
  }
}
