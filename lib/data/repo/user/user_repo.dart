import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/data/repo/auth/auth_repo.dart';

import '../../../features/personalisation/model/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepo extends GetxController{
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _onlineDB = FirebaseFirestore.instance;

  //save user data
  Future<void> saveUserRecord(UserModel user) async{
    try{
      await _onlineDB.collection("users").doc(user.id).set(user.toJson());
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //get user data
  Future<UserModel> fetchUserRecord() async{
    try{
      final userSnapshot = await _onlineDB
          .collection('users')
          .doc(AuthRepo.instance.authUser!.uid)
          .get();
      if (userSnapshot.exists) {
        return UserModel.fromDocument(userSnapshot);
      } else {
        return UserModel.empty();
        // throw Exception('User not found');
      }
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //update user data
  Future<void> updateUserRecord(UserModel updatedUser) async{
    try{
      await _onlineDB.collection("users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //update single field of user data
  Future<void> updateSingleField(String field, dynamic value) async{
    try{
      await _onlineDB.collection("users").doc(AuthRepo.instance.authUser!.uid).update({field: value});
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //delete user data
  Future<void> deleteUserRecord() async{
    try{
      await _onlineDB.collection("users").doc(AuthRepo.instance.authUser!.uid).delete();
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
}