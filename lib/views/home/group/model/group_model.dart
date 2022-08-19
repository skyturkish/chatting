import 'dart:convert';

class GroupModel {
  final String founder;
  final String groupName;
  final List<String> members;
  GroupModel({
    required this.founder,
    required this.groupName,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'founder': founder});
    result.addAll({'groupName': groupName});
    result.addAll({'members': members});

    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      founder: map['founder'] ?? '',
      groupName: map['groupName'] ?? '',
      members: List<String>.from(map['members']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));
}
