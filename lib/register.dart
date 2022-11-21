import 'package:brillo/displaysnack.dart';
import 'package:brillo/email_login.dart';
import 'package:brillo/phone.dart';
import 'package:brillo/validate.dart';
import 'package:brillo/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'brillo_dropdown.dart';
import 'my_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  bool success = false;
  String selectedItem = "Select Interest";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List sportList = [
    "Football",
    "Basketball",
    "Ice Hockey",
    "Motorsports",
    "Bandy",
    "Rugby",
    "Skiing",
    "Shooting"
  ];
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
        title: const Text("Register with Email"),
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
            const Text("Choose your Interest"),
            BrilloDropDown(
              sportList: sportList,
              onchaged: (value) {
                selectedItem = value.toString();
                setState(() {});
              },
              selectedItem: selectedItem,
            ),
            const SizedBox(
              height: 10,
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
                          emailController.text.isEmpty ||
                          selectedItem == "Select Interest") {
                        displaySnack(context, "please fill all fields");
                      } else {
                        try {
                          var result = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          await FirebaseFirestore.instance
                              .collection('interest')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({"interest": selectedItem});
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
                                builder: (context) => const VerifyEmail()));
                      }
                    },
                    child: const Text('Submit')),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Phone()));
                },
                child: const Text("Register with Phone Number")),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EmailLogin()));
                },
                child: const Text("Login with Email"))
          ]),
        ],
      )),
    );
  }
}
