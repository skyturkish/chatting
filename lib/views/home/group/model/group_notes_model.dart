import 'dart:convert';

class Groupnotes {
  final String groupName;
  final String createUserId;
  final String note;
  Groupnotes({
    required this.groupName,
    required this.createUserId,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupName': groupName});
    result.addAll({'createUserId': createUserId});
    result.addAll({'note': note});

    return result;
  }

  factory Groupnotes.fromMap(Map<String, dynamic> map) {
    return Groupnotes(
      groupName: map['groupName'] ?? '',
      createUserId: map['createUserId'] ?? '',
      note: map['note'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Groupnotes.fromJson(String source) => Groupnotes.fromMap(json.decode(source));
}
