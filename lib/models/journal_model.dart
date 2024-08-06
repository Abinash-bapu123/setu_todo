class JournalModel {
  int id;
  String? journal;
  String? createdDate;
  JournalModel({
    required this.id,
    required this.journal,
    required this.createdDate,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'] ?? 0,
      journal: json['journal'] ?? "",
      createdDate: json['createdDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'journal': journal,
      'createdDate': createdDate,
    };
  }
}
