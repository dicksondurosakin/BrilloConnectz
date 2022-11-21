import 'package:brillo/change_password.dart';
import 'package:brillo/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Buddies extends StatelessWidget {
  const Buddies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buddies")),
      body: const SafeArea(
          child: Center(
        child: Text("Buddies"),
      )),
    );
  }
}

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),
      body: const SafeArea(
          child: Center(
        child: Text("Discover"),
      )),
    );
  }
}

class SettingsPrivacy extends StatelessWidget {
  const SettingsPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings and Privacy")),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePassword(),
                    )),
                child: const Text("Change Password")),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                      (route) => false);
                },
                child: const Text("Logout"))
          ],
        ),
      )),
    );
    ;
  }
}
