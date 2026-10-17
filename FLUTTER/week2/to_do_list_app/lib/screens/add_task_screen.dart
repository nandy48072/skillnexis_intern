import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget{

  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>_AddTaskScreenState();

}

class _AddTaskScreenState extends State<AddTaskScreen>{


  final _formKey =GlobalKey<FormState>();

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController =TextEditingController();

  @override
  void dispose() {


    _taskController.dispose();
    _dateController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Column(

        children: [
          const Text("Task Details"),
          TextFormField(
            controller: _taskController,
              maxLines: 3,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.task)
              ),
          ),
          const Text("Select date"),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.date_range)
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              String newTask = _taskController.text;
              String date = _dateController.text;

              if (newTask.isNotEmpty && date.isNotEmpty) {
                // Combine task and date into a single string to pass back
                String result = "$newTask - $date";
                Navigator.pop(context, result);
              }
            },
            child: const Text(" Submit "),
          )
        ],

      ),
    );
  }
}
