import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knowyourself/data/repo/user/remote/user_repo.dart';
import '../../../utils/constants/text_strings.dart';
import '../../helper_service/backup_service/backup_service.dart';
import '/routes.dart';
import '/utils/exceptions/firebase_auth_exceptions.dart';
import '/utils/exceptions/firebase_exceptions.dart';
import '/utils/exceptions/format_exceptions.dart';
import '/utils/exceptions/platform_exceptions.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final UserRepo _userRepo = Get.put(UserRepo());
  final backupController = Get.put(BackupService());

  //get authenticaed user
  User? get authUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();


  @override
  void onReady() {
    super.onReady();
    screenRedirect();
  }

  screenRedirect() => Future.delayed(const Duration(milliseconds: 2000), () async {
    User? user = _auth.currentUser;
    if (user != null) {
      final isFirstTime = await _userRepo.fetchFirstTimeCreate(user.uid);
      if (isFirstTime == null || isFirstTime) {
        // isNewUser is null or true, redirect to profile setup.
        Get.offAllNamed(KRoutes.getProfileRoute());
      } else {
        // isNewUser is false, redirect to dashboard.
        // await syncData();
        Get.offAllNamed(KRoutes.getMasterRoute());
      }
    } else {
      // No user is logged in, show onboarding.
      Get.offAllNamed(KRoutes.getOnBoardingRoute());
    }
  });

  // Future<void> syncData() async {
  //   try {
  //     final user = _auth.currentUser;
  //     backupController.checkRemoteBackup().then((value) async {
  //       if (value) {
  //         print('Remote backup exists, importing data');
  //         await backupController.importRemoteData();
  //       }
  //     });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> _checkAndRedirect(User user) async {
    final isFirstTime = await _userRepo.fetchFirstTimeCreate(user.uid);
    if (isFirstTime == null || isFirstTime) {
      // isNewUser is null or true, redirect to profile setup.
      Get.offAllNamed(KRoutes.getProfileRoute());
    } else {
      // isNewUser is false, redirect to dashboard.
      Get.offAllNamed(KRoutes.getMasterRoute());
    }
  }

  //register user
  Future<UserCredential> registerUser(String email, String password) async {
    try{
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _checkAndRedirect(userCredential.user!);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw KTexts.errorMessage;
    }
  }

  //login user
  Future<UserCredential> loginUser(String email, String password) async {
    try{
      UserCredential userCredential= await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _checkAndRedirect(userCredential.user!);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw KTexts.errorMessage;
    }
  }

  //google sign in
  Future<UserCredential> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential= await _auth.signInWithCredential(credentials);
      await _checkAndRedirect(userCredential.user!);
      return userCredential;

    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw KTexts.errorMessage;
    }
  }

  //reset password
  Future<void> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw KTexts.errorMessage;
    }
  }
  //logout user
  Future<void> logoutUser() async {
    try{
      await GoogleSignIn().signOut();
      await _auth.signOut();
      deviceStorage.erase();
      deviceStorage.write('isLogged', false);
      // Get.offAllNamed(KRoutes.getOnBoardingRoute());
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw KTexts.errorMessage;
    }
  }
}