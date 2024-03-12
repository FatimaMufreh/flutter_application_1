import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController phoneNumberController = TextEditingController();
  String verificationId = '';

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> sendVerificationMessage() async {
    final phone = phoneNumberController.text.trim();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval completed (e.g., using SMS to automatically verify).
        // You can use the credential to sign in.
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        print("Verification completed: ${userCredential.user?.uid}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for future reference
        this.verificationId = verificationId;
        print("Code sent to $phone");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout (e.g., user didn't receive the SMS)
        this.verificationId = verificationId;
        print("Auto-retrieval timeout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendVerificationMessage,
              child: Text('Send Verification Message'),
            ),
          ],
        ),
      ),
    );
  }
}
