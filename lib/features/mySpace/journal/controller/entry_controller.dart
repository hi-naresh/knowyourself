import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/repo/space/insights/insights_repo.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../insights/controller/insights_controller.dart';
import '../model/journal_model.dart';
import 'journal_controller.dart';

class EntryController extends GetxController {
  static EntryController get instance => Get.find();
  final textEditingController = TextEditingController();

  // Selected image file , can be multiple
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  // User's location
  Rx<Position?> userPosition = Rx<Position?>(null);
  RxString location = ''.obs;

  // Sound recorder
  // FlutterSoundRecorder? soundRecorder;
  // bool isRecorderInitialized = false;
  // Recorded voice note path
  Rx<String?> voiceNotePath = Rx<String?>(null);


  @override
  void onClose() {
    // soundRecorder?.closeRecorder();
    // soundRecorder = null;
    super.onClose();
  }

  // Future<void> saveJournalEntry() async {
  //   if (textEditingController.text.isEmpty) {
  //     // Handle the case where there is no text entry
  //     KHelper.showSnackBar(KTexts.error, KTexts.journalEntryEmpty);
  //     return;
  //   }
  //
  //   // Create the journal entry object
  //   final entry = JournalEntry(
  //     id: DateTime.now().millisecondsSinceEpoch.toString(), // Or use a proper ID generator
  //     userId: UserController.instance.user.value.id!,
  //     content: textEditingController.text,
  //     entryDate: DateTime.now(),
  //     imagePath: selectedImage.value?.path,
  //     audioPath: voiceNotePath.value,
  //     locationPath: location.value?? 'No location',
  //   );
  //
  //   // Get the JournalController and save the entry
  //   final journalController = JournalController.instance;
  //   await journalController.addJournalEntry(entry);
  //
  //   // Clear the data in EntryController after saving
  //   deFocusKeyboard(Get.context!);
  //   KHelper.showSnackBar(KTexts.savedReflectionTitle, KTexts.savedReflectionMessage);
  //   textEditingController.clear();
  //   selectedImage.value = null;
  //   voiceNotePath.value = null;
  //   userPosition.value = null;
  // }

  Future<void> saveJournalEntry() async {
    if (textEditingController.text.isEmpty) {
      KHelper.showSnackBar(KTexts.error, KTexts.journalEntryEmpty);
      return;
    }

    final entry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: UserController.instance.user.value.id!,
      content: textEditingController.text,
      entryDate: DateTime.now(),
      imagePath: selectedImage.value?.path,
      audioPath: voiceNotePath.value,
      locationPath: location.value ?? 'No location',
    );

    // Save the journal entry
    final journalController = JournalController.instance;
    await journalController.addJournalEntry(entry);

    // Perform insights calculation
    final insightsController = Get.put(InsightsController());
    await insightsController.calculateInsightsForEntry(entry);

    // Log the analyzed core values after calculation
    final analyzedData = entry.coreValues ?? {};
    print('Analyzed Data for Entry ${entry.id}: $analyzedData');

    // Store the analyzed core values in the repository
    final insightsRepo = Get.put(InsightsRepo());
    await insightsRepo.storeAnalyzedCoreValues(entry.id!, analyzedData);

    // Log what has been saved
    print('Stored Analyzed Data for Entry ${entry.id}: ${await insightsRepo.fetchAnalyzedCoreValues(entry.id!)}');

    // Clear the data in EntryController after saving
    deFocusKeyboard(Get.context!);
    KHelper.showSnackBar(KTexts.savedReflectionTitle, KTexts.savedReflectionMessage);
    textEditingController.clear();
    selectedImage.value = null;
    voiceNotePath.value = null;
    userPosition.value = null;
  }


  Future<void> pickImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // selectedImage.map((list) => list?.add(image));
      selectedImage.value = image;
    } catch (e) {
      await Permission.photos.request();
      KHelper.showSnackBar(KTexts.permissionDeniedTitle, KTexts.enablePhotoPermission);
    }
  }

  void removeSelectedImage() {
    selectedImage.value = null;
  }

  Future<void> openCamera() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      selectedImage.value = image;
      // selectedImage.map((list) => list?.add(image));
    } catch (e) {
      await Permission.camera.request();
      KHelper.showSnackBar(KTexts.permissionDeniedTitle, KTexts.enableCameraPermission);
      openAppSettings();
    }
  }

  // Future<void> initializeRecorder() async {
  //   await Permission.microphone.request();
  //   soundRecorder = FlutterSoundRecorder();
  //   await soundRecorder!.openRecorder();
  //   isRecorderInitialized = true;
  // }
  // Future<void> recordVoiceNote() async {
  //   // if (!isRecorderInitialized) return;
  //   final status = await Permission.microphone.status;
  //   if (status == PermissionStatus.denied) {
  //     // print('Recording$status');
  //     openAppSettings();
  //   }
  //
  //   if (await Permission.microphone.isGranted) {
  //     // print('Recording');
  //     await soundRecorder!.startRecorder(toFile: 'voice_note.aac');
  //   } else {
  //     // Handle permission denied
  //     KHelper.showSnackBar('Permission denied', 'Please enable microphone permission');
  //     await Permission.microphone.request();
  //     openAppSettings();
  //   }
  // }
  // Future<void> stopRecording() async {
  //   if (isRecorderInitialized) {
  //     await soundRecorder!.stopRecorder();
  //     // save the audio with journal entry
  //     // voiceNotePath.value = soundRecorder!.path;
  //   }
  // }

  Future<void> addLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      userPosition.value = position;
      location.value = await getLocation();
    } else {
      // Handle location permission denied
      KHelper.showSnackBar(KTexts.permissionDeniedTitle, KTexts.enableLocationPermission);
      openAppSettings();
    }
  }

  Future<void> updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    userPosition.value = position;
    location.value = await getLocation();
  }

  Future<String> getLocation()  async {
    try {
      if (userPosition.value != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            userPosition.value!.latitude, userPosition.value!.longitude);
        // location.value = placemarks.first.name ?? "No nearby area found";
        // print("Location: ${placemarks.first.name}");
        return placemarks.first.name ?? KTexts.noNearbyAreaFound;
      } else {
        return KTexts.noNearbyAreaFound;
      }
    } catch (e) {
      // Handling any errors that occur during the reverse geocoding process
      print("Failed to get nearby area: $e");
      return KTexts.failedToGetNearbyArea;
    }
  }


  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMMM').format(now);
  }

  void deFocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
  void cancelEntry() {
    deFocusKeyboard(Get.context!);
    Get.back();
  }
  addBookmark() {}
}
