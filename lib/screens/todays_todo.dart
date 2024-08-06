import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:setu_todo/models/todo_model.dart';
import 'package:setu_todo/providors/todo_provider.dart';
import 'package:setu_todo/utils/app_assets.dart';
import 'package:setu_todo/utils/app_colors.dart';
import 'package:setu_todo/widgets/check_box_widget.dart';

class TodaysTodo extends StatefulWidget {
  const TodaysTodo({super.key});

  @override
  State<TodaysTodo> createState() => _TodaysTodoState();
}

class _TodaysTodoState extends State<TodaysTodo> {
  final TextEditingController _addTodoController = TextEditingController();

  void addTodo() async {
    final now = DateTime.now();
    final todo = TodoModel(
      id: now.microsecondsSinceEpoch,
      todoItem: _addTodoController.text,
      createdDate: "${now.day}/${now.month}/${now.year}",
    );
    context.read<TodoProvider>().addTodo(todo);
    _addTodoController.clear();
  }

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getTodos();
  }

  @override
  void dispose() {
    super.dispose();
    _addTodoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Consumer<TodoProvider>(
                  builder: (context, todoPr, _) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: todoPr.todos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            CircularCheckbox(
                              value: todoPr.todoChecksBoxes[index],
                              onChanged: (bool? value) {
                                todoPr.removeCheckbox(
                                  index,
                                  todoPr.todos[index].id,
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${todoPr.todos[index].todoItem}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Add Todo",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  content: TextField(
                    controller: _addTodoController,
                    maxLines: 4,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        addTodo();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.checkedIcon),
                const SizedBox(width: 10),
                Text(
                  "ADD A TASK",
                  style: GoogleFonts.manrope(
                    color: AppColors.buttonColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
