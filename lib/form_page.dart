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
  
}
