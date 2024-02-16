import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Questions.dart';
import '../../../provider/MySpace/question_provider.dart';

class QuestionSpace extends StatefulWidget {
  const QuestionSpace({super.key});

  @override
  State<QuestionSpace> createState() => _QuestionSpaceState();
}

class _QuestionSpaceState extends State<QuestionSpace> {
  final _questionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'short';

  void _addQuestion() {
    if (_questionController.text.isEmpty || _selectedDate == null) return;

    Provider.of<QuestionsProvider>(context, listen: false).addQuestion(
      Question(
        text: _questionController.text,
        deadline: _selectedDate,
        category: _selectedCategory,
      ),
    );
    _questionController.clear(); // Clear the text field after question is added
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void onPressed() {
    //modalSheet menu with daily, weekly, monthly, yearly

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              "Question Space"
          ),
          TextField(
            controller: _questionController,
            decoration: InputDecoration(labelText: 'Enter your question'),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${_selectedDate.toLocal()}',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _presentDatePicker,
                child: Text(
                  'Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(onPressed: onPressed,
                child: Text(
                  'Reminder',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text('Short-term'),
                selected: _selectedCategory == 'short',
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedCategory = 'short';
                    });
                  }
                },
              ),
              SizedBox(width: 20),
              ChoiceChip(
                label: Text('Long-term'),
                selected: _selectedCategory == 'long',
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedCategory = 'long';
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Add Question'),
            onPressed: _addQuestion,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Consumer<QuestionsProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.questions[index].text),
                      subtitle: Text(
                        'Deadline: ${value.questions[index].deadline.toLocal()}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // value.deleteQuestion(value.questions[index]);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
