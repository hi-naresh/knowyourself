import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${KTexts.edit} ${KTexts.profile} '),
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
                child: const Text('${KTexts.change} ${KTexts.profile} ${KTexts.picture}'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: KTexts.fullname,
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: KTexts.email,
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: KTexts.username,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text(KTexts.save),
              ),
            ],
          ),
        ),
      )
    );
  }
}
