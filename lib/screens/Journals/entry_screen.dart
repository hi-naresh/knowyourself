import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:knowyourself/screens/Journals/View%20Journal%20Screen/widgets/journal_icon_button.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';

class JournalEntryScreen extends StatefulWidget {
  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  TextEditingController _textEditingController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInitialized = false;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    _openAudioSession();
  }

  Future<void> _openAudioSession() async {
    await _soundRecorder!.isRecording;
    setState(() => isRecorderInitialized = true);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _soundRecorder!.isStopped;
    _soundRecorder = null;
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // Use the image file here...
  }

  Future<void> _recordVoiceNote() async {
    if (isRecorderInitialized) {
      await _soundRecorder!.startRecorder(toFile: 'voice_note.aac');
      // Start recording
    }
  }

  Future<void> _stopRecording() async {
    if (isRecorderInitialized) {
      await _soundRecorder!.stopRecorder();
      // Stop recording
    }
  }

  Future<void> _addLocation() async {
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

  @override
  Widget build(BuildContext context) {
    final he = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Row(
        //   children: [
        //
        //     const Spacer(),
        //     JournalIconButton(
        //       iconData:Icons.image_aspect_ratio,
        //       onPressed: () {
        //         // Save the journal entry
        //       },
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )
            ),
            Text(
              DateTime.now().toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: (){},
                child: Text('Save', style: TextStyle(color: Colors.blue))
            )
          ],
        ),
        TextField(
          controller: _textEditingController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Start writing...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _pickImage,
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: _addLocation,
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: _recordVoiceNote,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: _stopRecording,
              ),
            ],
          ),
        ),
        // Display hint questions for reflections here...
      ],
    );
  }
}