import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../features/mySpace/mood/model/mood_model_input.dart';

class ModelService extends GetxService {
  static ModelService get instance => Get.find();
  late final Interpreter interpreter;
  late final List<dynamic> activities;
  late final Map<String, dynamic> emotions;
  late final Map<String, dynamic> sentiments;
  late final List<int> inputShape;
  late final List<int> outputShape;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadModel();
    activities = await loadActivitiesJson('assets/mood_shifter/updated_activities.json');
    emotions = await loadEmotionsJson('assets/mood_shifter/emotions.json');
    sentiments = await loadJsonData('assets/mood_shifter/sentiments.json');
    initializeTensorShapes();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset("assets/mood_shifter/mood_shift.tflite");
    } catch (e) {
      print('Error loading the model: $e');
      rethrow;
    }
  }


  //load emotions.json
  Future<Map<String, dynamic>> loadEmotionsJson(String path) async {
    try {
      final String emotionsString = await rootBundle.loadString(path);
      return json.decode(emotionsString) as Map<String, dynamic>; // Ensure this matches the structure of your JSON
    } catch (e) {
      print('Error loading emotions: $e');
      rethrow;
    }
  }



  Future<Map<String, dynamic>> loadJsonData(String path) async {
    try {
      final String dataString = await rootBundle.loadString(path);
      return json.decode(dataString) as Map<String, dynamic>; // Ensure this matches the structure of your JSON
    } catch (e) {
      print('Error loading data: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> loadActivitiesJson(String path) async {
    try {
      final String activitiesString = await rootBundle.loadString(path);
      return json.decode(activitiesString) as List<dynamic>; // Ensure this matches the structure of your JSON
    } catch (e) {
      print('Error loading activities: $e');
      rethrow;
    }
  }

  void initializeTensorShapes() {
    inputShape = interpreter.getInputTensors()[0].shape;
    outputShape = interpreter.getOutputTensors()[0].shape;
    print("Input shape: $inputShape, Output shape: $outputShape");
  }

  // Future<int> predictMoodShiftFromModel(MoodModel moodModel) async {
  //   List<double> inputs = preprocessInputs(moodModel);
  //
  //   TensorBuffer inputTensor = TensorBuffer.createFixedSize(inputShape, TensorType.float32 as TfLiteType);
  //   inputTensor.loadList(inputs);
  //
  //   TensorBuffer outputTensor = TensorBuffer.createFixedSize(outputShape, TensorType.float32 as TfLiteType);
  //
  //   interpreter.run(inputTensor.buffer, outputTensor.buffer);
  //
  //   int predictedIndex = outputTensor.getIntValue(0);
  //   return predictedIndex;
  // }

  // List<double> preprocessInputs(MoodModel moodModel) {
  //   double moodIndex = mapMoodToIndex(moodModel.mood);
  //   double aspectIndex = mapAspectToIndex(moodModel.aspect);
  //   double placeIndex = mapPlaceToIndex(moodModel.happenedAt);
  //   double reasonIndex = moodModel.description.length.toDouble();
  //   return [moodIndex, aspectIndex, placeIndex, reasonIndex];
  // }

  // Example of a utility function to handle mood index based on the new structure
  double mapMoodToIndex(String mood) {
    for (var key in emotions.keys) {
      if (emotions[key].contains(mood)) {
        return emotions[key].indexOf(mood).toDouble();
      }
    }
    return 0.0; // default or error handling
  }


  // Function to retrieve activities based on the desired mood
  List<dynamic> getActivitiesForMood( int moodIndex, int aspectIndex, int placeIndex, int reasonIndex) {
    int aspectOffset = aspectIndex * 5;
    int placeOffset = placeIndex * 10;
    int reasonOffset = reasonIndex * 20;
    int startIndex = (moodIndex + aspectOffset + placeOffset + reasonOffset) % activities.length;
    int endIndex = (startIndex + 6).clamp(0, activities.length);
    return activities.sublist(startIndex, endIndex);
  }

  // double mapMoodToIndex(String mood) => emotions['mood']?[mood] ?? 0;
  double mapAspectToIndex(String aspect) => emotions['aspect']?[aspect] ?? 0;
  double mapPlaceToIndex(String place) => emotions['place']?[place] ?? 0;
}

// class TensorBuffer {
//   final List<int> shape;
//   final List<double> buffer;
//
//   TensorBuffer(this.shape, this.buffer);
//
//   factory TensorBuffer.createFixedSize(List<int> shape, TfLiteType type) {
//     int size = shape.reduce((a, b) => a * b);
//     List<double> buffer = List.filled(size, 0.0);
//     return TensorBuffer(shape, buffer);
//   }
//
//   void loadList(List<double> list) {
//     buffer.setRange(0, list.length, list);
//   }
//
//   int getIntValue(int index) {
//     return buffer[index].round();
//   }
// }

