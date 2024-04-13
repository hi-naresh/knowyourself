import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                // backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      )
    );
  }
}
