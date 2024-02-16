import 'package:flutter/material.dart';

import '../../Journals/Add Journal Screen/add_journal_screen.dart';

// import '../../MoodScreens/MoodScreen.dart';

class MoodWidget extends StatelessWidget {
  const MoodWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 208,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFCADDFC),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  height: 63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0x4DF5F5F5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Text(
                      "Express Your Mood & Reflect:\nLog emotions and write thoughts.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        // fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff393939), // Change the color as needed
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddJournalPageWidget(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
