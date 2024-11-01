class FriendInvite {
  final String senderId;
  final String receiverId;

  FriendInvite({
    required this.senderId,
    required this.receiverId,
  });

  factory FriendInvite.fromJson(Map<String, dynamic> json) {
    return FriendInvite(
      senderId: json['userId'],
      receiverId: json['friendUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': senderId,
      'friendUserId': receiverId,
    };
  }
}
