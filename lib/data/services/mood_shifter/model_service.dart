// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
//
// import '../../../features/mySpace/mood/model/mood_model_input.dart';
//
// class ModelService extends GetxService {
//
//   static ModelService get instance => Get.find();
//   late Interpreter _interpreter;
//   late List<String> activities = [];
//
//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await loadModel();
//     activities = await loadActivities();
//   }
//
//   Future<void> loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset("assets/mood-shifter/mood-shift.tflite");
//     } catch (e) {
//       print('Error while creating the interpreter: $e');
//     }
//   }
//
//   Future<List<String>> loadActivities() async {
//     final activitiesString = await rootBundle.loadString('assets/mood-shifter/activities.txt');
//     return activitiesString.split('\n').where((element) => element.isNotEmpty).toList();
//   }
//
//   Future<int> predictMoodShiftFromModel(MoodModel moodModel) async {
//     List<double> inputs = preprocessInputs(moodModel.mood, moodModel.aspect, moodModel.description, moodModel.happenedAt);
//
//     if (inputs.contains(null)) {
//       throw Exception('Preprocessed inputs contain null values.');
//     }
//
//     List<dynamic> output = List.filled(1, 0.0);
//     _interpreter.run(inputs, output);
//
//     return (output.first as double).round();
//   }
//
//
//   // Placeholder implementation: needs to be adapted based on your model's exact preprocessing needs
//   List<double> preprocessInputs(String mood, String aspect, String description, String happenedAt) {
//     // For mood, aspect, and place: Assuming these can be mapped to indices based on your dataset
//     double moodIndex = mapMoodToIndex(mood);
//     double aspectIndex = mapAspectToIndex(aspect);
//     double placeIndex = mapPlaceToIndex(happenedAt);
//
//     // For reason: You might need a more sophisticated approach to handle text, like embedding or tokenization
//     // This is a highly simplified placeholder
//     double reasonIndex = description.length.toDouble(); // Placeholder: Convert reason text to a numerical representation
//
//     return [moodIndex, aspectIndex, placeIndex, reasonIndex];
//   }
//
//   int predictMoodShift(List<double> inputs) {
//     // Assuming the model expects a flattened array of inputs
//     List<dynamic> inputList = inputs; // Adjust the type if necessary
//     List<dynamic> output = List.filled(1, 0.0); // Adjust based on your model's output size
//
//     _interpreter.run(inputList, output);
//
//     int predictedIndex = (output[0] as double).round();
//     return predictedIndex;
//   }
//
//   List<String> getActivitiesForMoodShift(int moodIndex) {
//     // Direct mapping of mood index to activities, simplified for demonstration
//     int startIndex = moodIndex % activities.length;
//     int endIndex = startIndex + 5; // Suggest up to 5 activities
//     endIndex = endIndex > activities.length ? activities.length : endIndex;
//     return activities.sublist(startIndex, endIndex);
//   }
//
//   // These methods need to be implemented based on how you've trained your model
//   double mapMoodToIndex(String mood) => 0; // Implement based on your data
//   double mapAspectToIndex(String aspect) => 0; // Implement based on your data
//   double mapPlaceToIndex(String place) => 0; // Implement based on your data
//
//
//   Future<List<String>> recommendActivities(MoodModel moodModel) async {
//     // Get predicted mood shift
//     int predictedMoodIndex = await predictMoodShiftFromModel(moodModel);
//
//     // Get recommended activities based on predicted mood shift
//     List<String> recommendedActivities = getActivitiesForMoodShift(predictedMoodIndex);
//
//     return recommendedActivities;
//   }
// }

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../features/mySpace/mood/model/mood_model_input.dart';

class ModelService extends GetxService {
  static ModelService get instance => Get.find();
  late final Interpreter interpreter;
  late final List<String> activities;
  late final List<int> _inputShape;
  late final List<int> _outputShape;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadModel();
    activities = await loadActivities();
    initializeTensorShapes();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset("assets/mood-shifter/mood-shift.tflite");
    } catch (e) {
      print('Error loading the model: $e');
      rethrow;  // Propagate error
    }
  }

  Future<List<String>> loadActivities() async {
    try {
      final String activitiesString = await rootBundle.loadString('assets/mood-shifter/activities.txt');
      return activitiesString.split('\n').where((element) => element.isNotEmpty).toList();
    } catch (e) {
      print('Error loading activities: $e');
      rethrow;
    }
  }

  void initializeTensorShapes() {
    _inputShape = interpreter.getInputTensors()[0].shape;
    _outputShape = interpreter.getOutputTensors()[0].shape;
    print("Input shape: $_inputShape, Output shape: $_outputShape");
  }

  Future<int> predictMoodShiftFromModel(MoodModel moodModel) async {
    List<double> inputs = preprocessInputs(moodModel);

    // Prepare input tensor
    TensorBuffer inputTensor = TensorBuffer.createFixedSize(_inputShape, TensorType.float32 as TfLiteType);
    inputTensor.buffer.setAll(0, inputs);


    // Prepare output tensor
    TensorBuffer outputTensor = TensorBuffer.createFixedSize(_outputShape, TensorType.float32 as TfLiteType);

    // Execute inference
    interpreter.run(inputTensor.buffer, outputTensor.buffer);

    // Process the output
    int predictedIndex = outputTensor.getIntValue(0);
    return predictedIndex;
  }


  List<double> preprocessInputs(MoodModel moodModel) {
    double moodIndex = mapMoodToIndex(moodModel.mood);
    double aspectIndex = mapAspectToIndex(moodModel.aspect);
    double placeIndex = mapPlaceToIndex(moodModel.happenedAt);
    double reasonIndex = moodModel.description.length.toDouble();
    return [moodIndex, aspectIndex, placeIndex, reasonIndex];
  }

  List<String> getActivitiesForMoodShift(int moodIndex) {
    int startIndex = moodIndex % activities.length;
    int endIndex = (startIndex + 5).clamp(0, activities.length);
    return activities.sublist(startIndex, endIndex);
  }

  // List<String> getActivitiesForMoodShift(String moodString) {
  //   double moodIndex = mapMoodToIndex(moodString);
  //   return getActivitiesForMoodShift(moodIndex);
  // }

  // Future<List<String>> getActivitiesForMoodShiftFromModel(MoodModel moodModel) async {
  //   int predictedMoodIndex = await predictMoodShiftFromModel(moodModel);
  //   return getActivitiesForMoodShift(predictedMoodIndex);
  // }

  double mapMoodToIndex(String mood) => 0;  // Example implementation
  double mapAspectToIndex(String aspect) => 0;  // Example implementation
  double mapPlaceToIndex(String place) => 0;  // Example implementation
}

class TensorBuffer {
  final List<int> shape;
  final List<double> buffer;

  TensorBuffer(this.shape, this.buffer);

  factory TensorBuffer.createFixedSize(List<int> shape, TfLiteType type) {
    int size = shape.reduce((a, b) => a * b);
    List<double> buffer = List.filled(size, 0.0);
    return TensorBuffer(shape, buffer);
  }

  int getIntValue(int index) {
    return buffer[index].round();
  }
}
