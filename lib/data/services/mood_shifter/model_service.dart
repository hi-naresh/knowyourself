import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../features/mySpace/mood/model/mood_model_input.dart';

class ModelService {
  late Interpreter _interpreter;
  List<String> activities = [];

  Future<void> init() async {
    _interpreter = await Interpreter.fromAsset('mood-shift.tflite');
    final activitiesString = await rootBundle.loadString('assets/mood-shifter/activities.txt');
    activities = activitiesString.split('\n').where((element) => element.isNotEmpty).toList();
  }

  // Placeholder implementation: needs to be adapted based on your model's exact preprocessing needs
  List<double> preprocessInputs(String mood, String aspect, String description, String happenedAt) {
    // For mood, aspect, and place: Assuming these can be mapped to indices based on your dataset
    double moodIndex = mapMoodToIndex(mood);
    double aspectIndex = mapAspectToIndex(aspect);
    double placeIndex = mapPlaceToIndex(happenedAt);

    // For reason: You might need a more sophisticated approach to handle text, like embedding or tokenization
    // This is a highly simplified placeholder
    double reasonIndex = description.length.toDouble(); // Placeholder: Convert reason text to a numerical representation

    return [moodIndex, aspectIndex, placeIndex, reasonIndex];
  }

  int predictMoodShift(List<double> inputs) {
    // Assuming the model expects a flattened array of inputs
    List<dynamic> inputList = inputs; // Adjust the type if necessary
    List<dynamic> output = List.filled(1, 0.0); // Adjust based on your model's output size

    _interpreter.run(inputList, output);

    int predictedIndex = (output[0] as double).round();
    return predictedIndex;
  }

  List<String> getActivitiesForMoodShift(int moodIndex) {
    // Direct mapping of mood index to activities, simplified for demonstration
    int startIndex = moodIndex % activities.length;
    int endIndex = startIndex + 5; // Suggest up to 5 activities
    endIndex = endIndex > activities.length ? activities.length : endIndex;
    return activities.sublist(startIndex, endIndex);
  }

  // Placeholder methods for mapping inputs to numerical indices
  // These methods need to be implemented based on how you've trained your model
  double mapMoodToIndex(String mood) => 0; // Implement based on your data
  double mapAspectToIndex(String aspect) => 0; // Implement based on your data
  double mapPlaceToIndex(String place) => 0; // Implement based on your data

  Future<int> predictMoodShiftFromModel(MoodModel moodModel) async {
    // Preprocess inputs
    List<double> inputs = preprocessInputs(
      moodModel.mood,
      moodModel.aspect,
      moodModel.description,
      moodModel.happenedAt,
    );

    // Perform prediction
    int predictedMoodIndex = predictMoodShift(inputs);

    return predictedMoodIndex;
  }

  Future<List<String>> recommendActivities(MoodModel moodModel) async {
    // Get predicted mood shift
    int predictedMoodIndex = await predictMoodShiftFromModel(moodModel);

    // Get recommended activities based on predicted mood shift
    List<String> recommendedActivities = getActivitiesForMoodShift(predictedMoodIndex);

    return recommendedActivities;
  }
}
