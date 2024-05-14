import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';

import '../../../controller/debug_controller.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DebugController());
    return Scaffold(
      appBar: KAppBar(
        back: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            ElevatedButton(
                onPressed:()=> controller.onPressed(),
                child: Text('Test Model')),
          ],
        ),
      ),
    );
  }
}
