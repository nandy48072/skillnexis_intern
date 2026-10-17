import 'package:flutter/material.dart';
import 'package:to_do_list_app/screens/add_task_screen.dart';

class TaskListScreen extends StatefulWidget{

  final String title;

  const TaskListScreen({super.key,required this.title});

  @override
  State<TaskListScreen> createState() =>_TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen>{

  List<String> tasks =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      // Removed the 'Center' widget here to prevent layout crashes!
      body: tasks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist_rounded, size: 80, color: Colors.deepPurple.shade200),
            const SizedBox(height: 16),
            const Text(
              "You don't have any tasks yet!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),

      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amberAccent,
                child: const Icon(Icons.task_alt, color: Colors.green),
              ),
              title: Text(tasks[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );

          // Fixed to isNotEmpty so it successfully adds valid tasks
          if (newTask != null && newTask.isNotEmpty) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }




}