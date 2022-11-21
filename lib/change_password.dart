import 'package:brillo/displaysnack.dart';
import 'package:brillo/email_login.dart';
import 'package:brillo/my_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyForm(
                controller: emailController,
                text: "Type your Email address",
                hint: "Email Address"),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: emailController.text.trim());
                displaySnack(context, "A link has been sent to your email");
              },
              child: const Text('Send Link'),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmailLogin()),
                      (route) => false);
                },
                child: const Text("Go to login Screen "))
          ],
        ),
      )),
    );
  }
}
