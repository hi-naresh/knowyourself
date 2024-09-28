import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import '../../../bindings/ai_model_binding.dart';
import '../../../utils/helpers/prompt_provider.dart';


class MoodShiftDeviceService extends GetxService {
  static MoodShiftDeviceService get instance => Get.find();
  final AIModelService _aiModelService;

  // MoodShiftDeviceService(this._aiModelService);
  MoodShiftDeviceService() : _aiModelService = AIModelService();
  Future<List<ActivityModel>> suggestActivities({
    required String mood,
    required String aspect,
    required String reason,
    required String place,
  }) async {
    final List<ActivityModel> activities = [];
    final List<String> activityTypes = ['cognitive', 'physical', 'emotional', 'spiritual'];
    final Set<String> usedTitles = {};
    final Set<String> usedInstructions = {};

    final String systemPrompt = PromptProvider.getSystemPrompt(PromptScenario.activityRecommendation);

    for (String activityType in activityTypes) {
      ActivityModel? activity;
      int retries = 3;

      while (activity == null && retries > 0) {
        try {
          final userPrompt = PromptProvider.generateActivityRecommendationUserPrompt(
            aspect: aspect,
            mood: mood,
            reason: reason,
            place: place,
            activityType: activityType,
          );

          print('Generating activity for type: $activityType');
          print('User Prompt: $userPrompt');

          final response = await _aiModelService.generateContent(systemPrompt, userPrompt);

          if (response != null) {
            activity = await _parseActivityResponse(response);

            if (activity != null && _isUniqueActivity(usedTitles, usedInstructions, activity)) {
              activities.add(activity);
              usedTitles.add(activity.title); // Track the title
              usedInstructions.add(activity.instructions!.join(' ')); // Track the concatenated instructions
              print('Activity ($activityType) added: ${activity.title}');
            } else if (activity != null) {
              print('Duplicate activity found: ${activity.title}, skipping...');
            }
          } else {
            throw Exception('Failed to generate content from AI model.');
          }
        } catch (e) {
          retries--;
          print('Error generating activity for $activityType: $e');
          if (retries > 0) {
            print('Retrying...');
          } else {
            print('Failed to generate a unique activity for $activityType after retries.');
          }
        }
      }
    }

    print('Generated ${activities.length} distinct activities.');
    return activities;
  }

  Future<ActivityModel?> _parseActivityResponse(String response) async {
    try {
      final Map<String, dynamic> parsedData = jsonDecode(_cleanJsonResponse(response));

      List<String> instructionsList;
      if (parsedData['instructions'] is String) {
        instructionsList = _parseInstructions(parsedData['instructions']);
      } else if (parsedData['instructions'] is List) {
        instructionsList = List<String>.from(parsedData['instructions']);
      } else {
        instructionsList = ['No instructions provided.'];
      }

      String link = parsedData['link'] ?? '';
      if (link.toLowerCase() == 'none' || link.isEmpty) {
        link = await _getFirstGoogleLink(parsedData['title'] ?? '');
      }

      return ActivityModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: parsedData['title'] ?? 'No Activity',
        instructions: instructionsList,
        link: link,
        duration: parsedData['duration'] ?? 'Duration not specified',
        imageUrl: '',
        color: Colors.white,
        tag: parsedData['tag'] ?? 'Untagged',
      );
    } catch (e) {
      print('Error parsing JSON response: $e');
      return null; // Returning null here so that the retry logic can handle it.
    }
  }

  String _cleanJsonResponse(String response) {
    return response.replaceAll('```json', '').replaceAll('```', '').trim();
  }

  //       .split(RegExp(r'[\n\r]+|(\d+\.\s)|(\*\s)'))
  List<String> _parseInstructions(String instructions) {
    return instructions
        .split(RegExp(r'\.\s+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  Future<String> _getFirstGoogleLink(String title) async {
    final query = Uri.encodeQueryComponent(title);
    final googleSearchUrl = 'https://www.google.com/search?q=$query';

    try {
      final response = await http.get(Uri.parse(googleSearchUrl));
      final document = html.parse(response.body);

      final searchResults = document.querySelectorAll('a[href^="/url?q="]');

      for (var result in searchResults) {
        final rawLink = result.attributes['href'];
        if (rawLink != null && rawLink.startsWith('/url?q=')) {
          final link = Uri.decodeComponent(rawLink.substring(7).split('&')[0]);
          if (_isValidUrl(link)) {
            return link;
          }
        }
      }
    } catch (e) {
      print('Error fetching Google search link: $e');
    }

    return '';
  }

  bool _isValidUrl(String url) {
    return url.startsWith('http') && !url.contains('google.com');
  }

  bool _isUniqueActivity(Set<String> usedTitles, Set<String> usedInstructions, ActivityModel newActivity) {
    return !usedTitles.contains(newActivity.title) &&
        !usedInstructions.contains(newActivity.instructions?.join(' '));
  }
}
