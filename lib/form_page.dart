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

      return Container(
        height: 350,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Set Task Date & Time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color.fromARGB(255, 0, 0, 0), size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Date & Time Picker
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: _selectedDateTime ?? DateTime.now(),
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: false, 
                onDateTimeChanged: (DateTime newDate) {
                  tempPickedDate = newDate;
                },
              ),
            ),

            const SizedBox(height: 10),

            // Tombol untuk memilih waktu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDateTime = tempPickedDate;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Select",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
    void _addTask() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDateTime == null) {
        // Jika user belum memilih tanggal, munculkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Please select a date first!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating, 
            margin: const EdgeInsets.all(16), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), 
            ),
            duration: const Duration(seconds: 2), 
          ),
        );
        return; // Stop eksekusi biar tidak lanjut ke bawah
      }

      setState(() {
        _tasks.add(Task(title: _taskController.text, deadline: _selectedDateTime!));
        _taskController.clear();
        _selectedDateTime = null;
      });

      // Menampilkan Snackbar sukses 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Task added successfully",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal, 
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Fungsi untuk mengganti status tugas
  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  // Fungsi format tanggal manual
  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-"
           "${dateTime.month.toString().padLeft(2, '0')}-"
           "${dateTime.year} "
           "${dateTime.hour.toString().padLeft(2, '0')}:"
           "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Input
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Task Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),

                  // Pilih Tanggal & Waktu
                  Row(
                    children: [
                      Text(
                        _selectedDateTime == null
                            ? "Select a date"
                            : formatDateTime(_selectedDateTime!),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: Color.fromARGB(255, 0, 0, 0), size: 30),
                        onPressed: () => _showDateTimePicker(context),
                      ),
                    ],
                  ),

                  if (_selectedDateTime == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Please select a date",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      // Input Nama Tugas 
                      Expanded(
                        child: TextFormField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            labelText: "Nama Tugas",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            }
                            return null;
                          },
                        ),
                      ),
                      
                      const SizedBox(width: 10), // Jarak antara input dan tombol

                      // Tombol Submit
                      SizedBox(
                        height: 50, // Menyamakan tinggi tombol dengan input
                        child: ElevatedButton(
                          onPressed: _addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple, // Warna tombol
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 20), // Padding horizontal
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white, // Warna teks putih
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          
              )
            ),
          ],
        ),
      ),
    );
  }
}
