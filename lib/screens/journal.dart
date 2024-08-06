import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:setu_todo/providors/todo_provider.dart';
import 'package:setu_todo/utils/app_colors.dart';
import 'package:setu_todo/utils/extensions.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final DateTime now = DateTime.now();
  final TextEditingController _editJournalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${now.monthName} ${now.day}, ${now.year}",
          style: GoogleFonts.manrope(
            color: AppColors.editButtonColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.029,
        ),
        Expanded(
          child: Consumer<TodoProvider>(
            builder: (context, journalPr, _) {
              final isJournalEditState = journalPr.isJournalEditState;
              _editJournalController.text = journalPr.editFieldText;
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                width: double.infinity,
                decoration: isJournalEditState
                    ? BoxDecoration(
                        border: Border.all(
                          color: AppColors.textBoxBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      )
                    : null,
                child: isJournalEditState
                    ? TextField(
                        controller: _editJournalController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          journalPr.onEditFieldChange(value);
                        },
                      )
                    : Text(
                        journalPr.journalDetails.journal!,
                        style: GoogleFonts.manrope(
                          color: AppColors.appText,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
