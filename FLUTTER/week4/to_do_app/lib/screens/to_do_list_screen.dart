import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/database_provider.dart';
import 'package:to_do_app/screens/login_screen.dart';
import 'package:to_do_app/screens/profile_screen.dart';

class ToDoListScreen extends StatefulWidget{
  const ToDoListScreen({super.key});

  @override
  State<StatefulWidget> createState()=>_ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen>{

  final  DatabaseProvider _dbProvider=DatabaseProvider();
  final TextEditingController _taskController=TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog(BuildContext context){
    _taskController.clear();
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text('Add New Task'),
            content: TextField(
              controller: _taskController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter task description',
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade500,width:2),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () =>Navigator.pop(context),
                  child: const Text('Cancel',style: TextStyle(
                    color: Colors.grey
                  ),
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if(_taskController.text.trim().isNotEmpty){

                      await _dbProvider.addTask(_taskController.text.trim());
                      if(!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'))

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>ProfileScreen()
                  )
              );
            },
            icon: const Icon(Icons.person)),
        title: Text('To do List',
          style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold

          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed:() async{
                await FirebaseAuth.instance.signOut();
                if(!context.mounted) return;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>LoginScreen(title: 'Login'))
                );
              },
              icon: Icon(Icons.logout)
          )

        ],

      ),

      body: StreamBuilder(
          stream: _dbProvider.getTasks(),
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.red));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final tasks = snapshot.data ?? [];

            if (tasks.isEmpty) {
              return Center(
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                    child: Text(
                      'No tasks yet. Tap + to add one!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: tasks.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context,index) {
                  final task = tasks[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        activeColor: Colors.red.shade500,
                        value: task.isCompleted,
                        onChanged: (bool? value) {
                          if (value != null) {
                            _dbProvider.updateTaskStatus(task.id, value);
                          }
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _dbProvider.deleteTask(task.id),
                      ),
                    ),
                  );


                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade500,
        foregroundColor: Colors.white,
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );

  }

}