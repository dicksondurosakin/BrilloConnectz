import 'package:brillo/displaysnack.dart';
import 'package:brillo/home.dart';
import 'package:brillo/phone.dart';
import 'package:brillo/phone_login.dart';
import 'package:brillo/register.dart';
import 'package:brillo/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_form.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLogin();
}

class _EmailLogin extends State<EmailLogin> {
  bool isLoading = false;
  bool success = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Email"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 70,
            ),
            MyForm(
              controller: emailController,
              text: "Email",
              hint: "Enter your Email",
              validator: (value) => validateEmail(value),
            ),
            MyForm(
              obscureText: true,
              controller: passwordController,
              text: "Password",
              hint: "Enter your Password",
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        success = false;
                        isLoading = true;
                      });
                      if (passwordController.text.isEmpty ||
                          emailController.text.isEmpty) {
                        displaySnack(context, "please fill all fields");
                      } else {
                        try {
                          var result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          success = true;
                        } on FirebaseAuthException catch (e) {
                          success = false;
                          displaySnack(
                              context, removeParenthesis(e.toString()));
                        }
                      }

                      setState(() {
                        isLoading = false;
                      });
                      if (!mounted) return;
                      if (success) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    child: const Text('Submit')),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneLogin()),
                      (route) => false);
                },
                child: const Text("Login with Phone Number")),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                      (route) => false);
                },
                child: const Text("Register"))
          ]),
        ],
      )),
    );
  }
}
