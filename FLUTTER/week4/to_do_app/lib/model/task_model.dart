class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;
  final String userId;

  const TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      userId: map['userId'] ?? '',
    );
  }
}