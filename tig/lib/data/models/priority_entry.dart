class PriorityEntry {
  String priority;
  bool isSucceed;

  PriorityEntry({
    required this.priority,
    required this.isSucceed,
  });

  Map<String, dynamic> toMap() {
    return {
      'priority': priority,
      'isSucceed': isSucceed,
    };
  }

  factory PriorityEntry.fromMap(Map<String, dynamic> map) {
    return PriorityEntry(
      priority: map['priority'] ?? '',
      isSucceed: map['isSucceed'] ?? false,
    );
  }
}