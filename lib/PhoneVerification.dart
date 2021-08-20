import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification_flutter/HomePage.dart';
import 'package:international_phone_input/international_phone_input.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String smsCode;
  String verificationCode;
  String number;
  String _phone;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
      print(internationalizedPhoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  "Enter Your Phone Number",
                  style: TextStyle(
                    color: Colors.orange[400],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InternationalPhoneInput(
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(
                    color: Colors.orange[500],
                  ),
                ),
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: _phone,
                initialSelection: 'US',
                showCountryCodes: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ButtonTheme(
                  height: 50,
                  minWidth: width,
                  child: RaisedButton.icon(
                    onPressed: () {
                      _submit();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: Text("Send code"),
                    color: Colors.orange[300],
                    textColor: Colors.white,
                    splashColor: Colors.orange[800],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      setState(() {
        print("Verification");
        print(credential);
      });
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this._phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Enter Code",
              style: TextStyle(
                color: Colors.orange[900],
              ),
            ),
            content: TextField(
              onChanged: (Value) {
                smsCode = Value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.orange[900],
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((user) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ))
        .catchError((e) => print(e));
  }
}
