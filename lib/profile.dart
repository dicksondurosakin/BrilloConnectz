import 'package:brillo/email_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var myData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedItem();
  }

  Future getSelectedItem() async {
    DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('interest')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      myData = (result.data()! as dynamic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                  child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSitg48P2zHSYu9N_Li61Z3Ldul4UZBQtoZDA&usqp=CAU",
                fit: BoxFit.fill,
                height: 120,
                width: 140,
                // heigh,
              )),
              const SizedBox(
                height: 20,
              ),
              FirebaseAuth.instance.currentUser!.email != null
                  ? Text(
                      "Your Email is ${FirebaseAuth.instance.currentUser!.email!}")
                  : const Text(""),
              FirebaseAuth.instance.currentUser!.phoneNumber != null
                  ? Text(
                      "Your Phone Number is ${FirebaseAuth.instance.currentUser!.phoneNumber!}")
                  : const Text(""),
              Text("The Sport you chose was ${myData['interest'] ?? ""} "),
              const Text(""),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailLogin()),
                        (route) => false);
                  },
                  child: const Text("Sign Out"))
            ],
          ),
        )));
  }
}
