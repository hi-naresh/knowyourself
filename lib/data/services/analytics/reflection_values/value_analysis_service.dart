import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ValueAnalysisService extends GetxService {
  static ValueAnalysisService get instance => Get.find();
  late List<String> _coreValues;
  late List<String> loadEntries;
  late final Interpreter interpreter;
  late final List<int> inputShape;
  late final List<int> outputShape;

  @override
  void onInit() {
    super.onInit();
    _loadModel();
    _loadCoreValues();
    _loadEntries();
  }

  void _loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/value_analysis/value_analysis.tflite');
    interpreter.allocateTensors();
    print("Model loaded successfully!");
    initializeShapes();
  }

  void initializeShapes() {
    inputShape = interpreter.getInputTensors()[0].shape;
    outputShape = interpreter.getOutputTensors()[0].shape;
    print("Input shape: $inputShape, Output shape: $outputShape");
  }

  void _loadCoreValues() async {
    final jsonString = await rootBundle.loadString('assets/value_analysis/core_values.txt');
    final jsonMap = jsonDecode(jsonString);
    _coreValues = jsonMap.keys.toList();  // Assuming the keys are the core values
    print("Core values loaded successfully: $_coreValues");
  }

  void _loadEntries() async {
    final entriesString = await rootBundle.loadString('assets/value_analysis/journal_entries.txt');
    loadEntries = const LineSplitter().convert(entriesString);
    print("Entries loaded successfully!");
  }

  Future<Map<String, double>> analyzeText(String text) async {
    var input = _preprocessText(text);
    var inputVector = [Float32List.fromList(input)];
    print("Input vector: $inputVector");

    var output = List<double>.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);
    print("Output vector: $output");
    interpreter.run(inputVector, output);

    return _mapOutputToPercentages(output[0]);
  }

  List<double> _preprocessText(String text) {
    var processed = List<double>.filled(256, 0.0); // Example with fixed length
    return processed;  // Convert to Float32List where needed
  }

  Map<String, double> _mapOutputToPercentages(List<double> modelOutput) {
    var total = modelOutput.reduce((a, b) => a + b);
    var percentages = <String, double>{};
    for (var i = 0; i < modelOutput.length; i++) {
      percentages[_coreValues[i]] = (modelOutput[i] / total) * 100;
    }
    return percentages;
  }

  String formatResults(Map<String, double> results) {
    return results.entries.map((e) => '${e.key}: ${e.value.toStringAsFixed(2)}%').join(', ');
  }
}

