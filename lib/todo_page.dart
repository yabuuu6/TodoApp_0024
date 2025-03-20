import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage ({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends 
State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();

  List<String> listTugas = [];

  void addData(){
    setState(() {
      listTugas.add(_taskController.text);
      _taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('./assets/images/barca1.jpg')),
                    Text('Bayer', style: TextStyle(fontSize: 20),)
                  ],
              ),
              Form(
                key: _key,
                child: Row(
                children: [
                Expanded(
                  child: TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    label:Text('UCL'),
                    hintText: 'Enter your champions league',
                    ),
                    validator: (value) {
                      if(value !.isEmpty) {
                        return 'Please enter your champions league';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              ),
              FilledButton(onPressed: () {
                if (_key.currentState!.validate()) {
                  addData();
                }
              }, child: Text('Submit'))
              ],
              ),
              ),
              Expanded(
                child: ListView.builder(
                itemCount: listTugas.length, 
                itemBuilder: (context, index){
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300], 
                      borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Jumlah UCL :'), Text(listTugas[index])],
                    ),
                  );
                }
              ,)
              ,)
            ],
          ),
        ),
      ),
    );
  }
}