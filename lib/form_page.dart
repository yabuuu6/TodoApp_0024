import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime deadline;
  bool isDone;

  Task({required this.title, required this.deadline, this.isDone = false});
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDateTime;
  List<Task> _tasks = [];

void _showDateTimePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext builder) {
      DateTime tempPickedDate = _selectedDateTime ?? DateTime.now();

    }
}