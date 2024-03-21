import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/repo/user/user_repo.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepo = Get.put(UserRepo());
  Rx<UserModel> user = UserModel.empty().obs;


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //get user data
  Future<void> fetchUserRecord() async{
    try{
      final userSnapshot = await userRepo.fetchUserRecord();
      this.user(userSnapshot);
      // return userSnapshot;
    } catch(e){
      KHelper.showSnackBar("Data not found!", "Something went wrong. Try again.");
      user(UserModel.empty());
    }
  }


  //save user data from any provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async{
    try{
      if(userCredentials != null) {
        final user = userCredentials.user;

        final newUser = UserModel(
          id: user?.uid,
          email: user?.email!,
          fullName: user!.displayName,
          username: user.email!.split('@').first,
          profilePhotoUrl: user.photoURL??''
        );

        await userRepo.saveUserRecord(newUser);
      }
    } catch(e){
      KHelper.showSnackBar("Data not saved!", "Something went wrong. Try again.");
    }
  }

  //points update
  // int _score = SharedPreferencesHelper.getPoints();
  // int get getScore => _score;
  // void setScore({required int point}) {
  //   SharedPreferencesHelper.saveScores(point);
  //   _score = _score + point;
  // }

}