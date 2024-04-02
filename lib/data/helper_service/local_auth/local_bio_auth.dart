import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class LocalBioAuth extends GetxService {
  static LocalBioAuth get instance => Get.find();
  final LocalAuthentication _auth = LocalAuthentication();
  final GetStorage _storage = GetStorage();
  final _authEnabledKey = 'isBioAuthEnabled';

  // Observable variable to track if biometric auth is enabled.
  final isAuthEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the biometric auth enabled state from storage on service initialization.
    _loadAuthEnabledState();
  }

  // Load the authentication enabled state from GetStorage.
  Future<void> _loadAuthEnabledState() async {
    bool isEnabled = _storage.read(_authEnabledKey) ?? false;
    isAuthEnabled.value = isEnabled;
  }

  // Toggle the state of biometric authentication and persist the preference.
  Future<void> toggleBioAuth(bool isEnabled) async {
    await _storage.write(_authEnabledKey, isEnabled);
    isAuthEnabled.value = isEnabled;
  }

  Future<bool> hasBiometrics() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  Future<bool> authenticateWithBiometrics() async {
    if (!isAuthEnabled.value) return false; // Check if biometric auth is enabled.

    try {
      final isAvailable = await hasBiometrics();
      if (!isAvailable) return false;
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
}
