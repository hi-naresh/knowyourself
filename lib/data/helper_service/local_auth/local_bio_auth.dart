import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalBioAuth extends GetxService {
  static LocalBioAuth get instance => Get.find();
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      final isAuthAvailable = await hasBiometrics();
      if (!isAuthAvailable) return false;
      return await _auth.authenticate(
        localizedReason: 'Authenticate to access your space',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> cancelAuthentication() async {
    await _auth.stopAuthentication();
  }

  // Future<void> navigateToMySpace(BuildContext context) async {
  //   bool isAuthenticated = await LocalAuthUtil.authenticateWithBiometrics();
  //   if (isAuthenticated) {
  //     Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => MySpaceScreen(),
  //     ));
  //   } else {
  //     // Handle authentication failure
  //     // This could be showing an error, or taking the user back to a safe screen
  //   }
  // }

}
