import 'package:brillo/brillo_dropdown.dart';
import 'package:brillo/displaysnack.dart';
import 'package:brillo/email_login.dart';
import 'package:brillo/otp.dart';
import 'package:brillo/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_form.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phoneNoController = TextEditingController();
  String selectedItem = "Select Interest";
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
  bool isLoading = false;
  bool success = false;

  @override
  void dispose() {
    super.dispose();
    phoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register with Phone Number"),
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
              maxLength: 10,
              controller: phoneNoController,
              text: "Phone Number (+234)",
              hint: "Phone Number",
              keyboardType: const TextInputType.numberWithOptions(),
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
                      if (selectedItem == "Select Interest" ||
                          phoneNoController.text.isEmpty) {
                        displaySnack(context, "please fill all fields");
                      } else {
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                    phoneNoController.text, selectedItem)));
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmailLogin()),
                      (route) => false);
                },
                child: const Text("Login with Email")),
          ]),
        ],
      )),
    );
    ;
  }
}
