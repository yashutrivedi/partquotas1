import 'package:flutter/material.dart';
import 'package:partquotes_admin/screens/login.dart';

class Admin_setting extends StatefulWidget {
  const Admin_setting({super.key});

  @override
  State<Admin_setting> createState() => _Admin_settingState();
}

class _Admin_settingState extends State<Admin_setting> {
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
                    builder: ((context) => LoginPage()),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
