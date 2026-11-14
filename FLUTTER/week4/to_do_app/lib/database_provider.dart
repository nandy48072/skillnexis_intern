import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/task_model.dart';

class DatabaseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  // Stream to fetch tasks in real-time
  Stream<List<TaskModel>> getTasks() {
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.id, doc.data()!)) // Added ! for null safety
        .toList());
  }

  // Add a new task
  Future<void> addTask(String title) async {
    if (uid == null) return;
    await _firestore.collection('tasks').add({
      'title': title,
      'isCompleted': false,
      'userId': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update task completion status
  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'isCompleted': isCompleted,
    });
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}