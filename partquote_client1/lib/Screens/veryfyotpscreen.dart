import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partquote_client/Screens/dashboard.dart';

class Verifyotp extends StatefulWidget {
  final String verificationId;
  const Verifyotp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ClientDashboard())); // Corrected the class name
      }
    } on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify OTP"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: otpController,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: "6-Digit OTP",
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: isPortrait ? 20.0 : 40.0,
              ),
              ElevatedButton(
                onPressed: () {
                  verifyOTP();
                },
                child: Text("Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
