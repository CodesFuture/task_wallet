class Task {
  final int? taskId;
  final String taskTitle;
  final String description;
  final String dueDate;
  final String priority;
  final String assignee;
  final String status;

  Task({
    this.taskId,
    required this.taskTitle,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.assignee,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': taskId,
      'taskTitle': taskTitle,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'assignee': assignee,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['id'],
      taskTitle: map['taskTitle'],
      description: map['description'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      assignee: map['assignee'],
      status: map['status'],
    );
  }

  Task copyWith({
    int? id,
    String? taskTitle,
    String? description,
    String? dueDate,
    String? priority,
    String? assignee,
    String? status,
  }) {
    return Task(
      taskId: id ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
    );
  }
}