import 'package:flutter/material.dart';
import 'package:setu_todo/models/journal_model.dart';
import 'package:setu_todo/models/todo_model.dart';
import 'package:setu_todo/services/db_services.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = [];
  String _editFieldText = "";
  JournalModel? _journalDetails = JournalModel(
    id: 0,
    journal: "",
    createdDate: "",
  );
  List<bool> _todoChecksBoxes = [];
  bool _isJournalEditState = false;

  List<TodoModel> get todos => _todos;
  String get editFieldText => _editFieldText;
  List<bool> get todoChecksBoxes => _todoChecksBoxes;
  bool get isJournalEditState => _isJournalEditState;
  JournalModel get journalDetails => _journalDetails!;

  void onEditFieldChange(String text) {
    _editFieldText = text;
    notifyListeners();
  }

  void changeJournalEditState(bool isSave) {
    _isJournalEditState = !_isJournalEditState;
    if (isSave) {
      final journal = JournalModel(
        id: _journalDetails!.id,
        journal: _editFieldText,
        createdDate: _journalDetails!.createdDate,
      );
      updateJournal(journal, _journalDetails!.id);
    }
    notifyListeners();
  }

  void addJournal(JournalModel journal) async {
    DbHelper db = DbHelper();
    await db.insertJournal(journal);
    getJournal();
  }

  void getJournal() async {
    DbHelper db = DbHelper();
    _journalDetails = await db.getJournal();
    if (journalDetails.id == 0) {
      final now = DateTime.now();
      final journal = JournalModel(
        id: now.microsecondsSinceEpoch,
        journal: "",
        createdDate: "${now.day}/${now.month}/${now.year}",
      );
      addJournal(journal);
    }
    _editFieldText = _journalDetails!.journal!;
    notifyListeners();
  }

  void updateJournal(JournalModel journal, int id) async {
    DbHelper db = DbHelper();
    await db.updateJournal(journal, id);
    getJournal();
  }

  void addTodo(TodoModel todo) async {
    DbHelper db = DbHelper();
    await db.insertTodo(todo);
    getTodos();
  }

  void removeTodo(int id) async {
    DbHelper db = DbHelper();
    await db.removeTodo(id);
    getTodos();
  }

  void getTodos() async {
    DbHelper db = DbHelper();
    _todos = await db.getTodos();
    _todoChecksBoxes = List.generate(_todos.length, (i) => false);
    notifyListeners();
  }

  void removeCheckbox(int index, int id) async {
    todoChecksBoxes[index] = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    removeTodo(id);
  }
}
