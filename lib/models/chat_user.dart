class ChatUser {
  final String recieverName;
  final String recieverId;
  final String? conversationDisplayName;
  final String? conversationId;

  ChatUser({
    required this.recieverName,
    required this.recieverId,
    this.conversationDisplayName,
    this.conversationId,
  });
  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      recieverName: json['name'] as String,
      recieverId: json['id'] as String,
    );
  }
}
