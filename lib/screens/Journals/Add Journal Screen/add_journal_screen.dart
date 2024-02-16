import 'package:flutter/material.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/aspect_select.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/express_feelings.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/View%20Journal%20Screen/view_journal_screen.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/mood_select_widget.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/note_text_field_widget.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/title_text_field_widget.dart';

class AddJournalPageWidget extends StatefulWidget {
  const AddJournalPageWidget({super.key});

  @override
  State<AddJournalPageWidget> createState() => _AddJournalPageWidgetState();
}

class _AddJournalPageWidgetState extends State<AddJournalPageWidget> {
  final List<Widget> _journalPages = [
    const MoodSelectWidget(),
    // const TitleTextFieldWidget(),
    const AspectSelectWidget(),
    // const NotesTextFieldWidget(),
    const ExpressFeelingsWidget(),
    const ViewJournalScreen(readOnly: false),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        _index = value.index;
        return WillPopScope(
          onWillPop: () async {
            if (_index == 0) {
              value.clearJournalData();
              Navigator.pop(context);

              return false;
            }
            _index -= 1;
            value.updateIndex(_index);
            return false;
          },
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: value.pageController,
            children: _journalPages,
          ),
        );
      },
    );
  }
}
