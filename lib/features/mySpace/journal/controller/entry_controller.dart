import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EntryController extends GetxController {
  static EntryController get instance => Get.find();

  final textEditingController = TextEditingController();
  FlutterSoundRecorder? soundRecorder;
  bool isRecorderInitialized = false;

  @override
  void initState() {
    soundRecorder = FlutterSoundRecorder();
    _openAudioSession();
  }

  Future<void> _openAudioSession() async {
    soundRecorder!.isRecording;
    // setState(() => isRecorderInitialized = true);
  }

  // @override
  // void dispose() {
  //   _textEditingController.dispose();
  //   soundRecorder!.isStopped;
  //   soundRecorder = null;
  //   super.dispose();
  // }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // Use the image file here...
  }

  Future<void> recordVoiceNote() async {
    if (isRecorderInitialized) {
      await soundRecorder!.startRecorder(toFile: 'voice_note.aac');
      // Start recording
    }
  }

  Future<void> stopRecording() async {
    if (isRecorderInitialized) {
      await soundRecorder!.stopRecorder();
      // Stop recording
    }
  }

  Future<void> addLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    // Use the position object to get the location data.
  }

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    // final String formattedDate = DateFormat('MM/dd').format(now);
    final String formattedDate = DateFormat('EEEE, dd MMMM').format(now);
    return formattedDate;
  }

  addBookmark() {}

  deFocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

}