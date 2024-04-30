import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:partquote_client/Screens/firesbaseService.dart';
import 'package:partquote_client/Screens/home.dart';
import 'package:partquote_client/Screens/user_service.dart';
import 'package:partquote_client/Screens/veryfyotpscreen.dart';
import 'package:partquote_client/model/userModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phNoController = TextEditingController();

  void sendOTP() async {
    String phone = '+91${_phNoController.text.trim()}';

    final user =
        await FirebaseService.findUser(_phNoController.text.toString());

    print("User is $user");

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Not Found')),
      );
    } else {
      final userData = user.data();

      if (userData != null) {
        UserService.saveUser(UserData.fromJson(userData));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ));
      } else {
        // Handle case where userData is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data is not available')),
        );
      }

      // UserService.saveUser(UserData.fromJson(user));

      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => BottomNavigation(),
      // ));

      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: phone,
      //   codeSent: (verificationId, resendToken) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Verifyotp(
      //           verificationId: verificationId,
      //         ),
      //       ),
      //     );
      //   },
      //   verificationCompleted: (credential) {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => BottomNavigation(),
      //       ),
      //     );
      //   },
      //   verificationFailed: (ex) {
      //     print(ex.code.toString());
      //   },
      //   codeAutoRetrievalTimeout: (verificationId) {},
      //   timeout: Duration(seconds: 30),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie.asset('assets/login.json', height: mq.height * 0.2),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: _phNoController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendOTP();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Processing Data: ${_phNoController.text}')),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
