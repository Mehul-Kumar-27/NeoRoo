class Messages {
  late String subject;
  late String text;
  late List<dynamic> userGroups;
  late List<dynamic> users;
  late String userId;
  Messages({
    required this.subject,
    required this.text,
    required this.userGroups,
    required this.users,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    subject = json["subject"];
    text = json["text"];
    userGroups = json["userGroups"];
    users = json["users"];
  }
}