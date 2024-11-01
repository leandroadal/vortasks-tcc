import 'package:flutter/material.dart';
import 'package:vortasks/models/social/friendship_data.dart';
import 'package:vortasks/screens/social/friends/friend_info_screen.dart';
import 'package:vortasks/stores/social/friend_store.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
    required this.context,
    required this.friend,
    required this.friendshipId,
    required this.friendStore,
  });

  final BuildContext context;
  final FriendshipData friend;
  final String friendshipId;
  final FriendStore friendStore;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[700],
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FriendInfoScreen(
                      friendshipId: friendshipId,
                      friendData: friend,
                    )),
          ),
          child: Text(
            friend.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.person_remove, color: Colors.white),
          onPressed: () async {
            await friendStore.removeFriend(friendshipId);
          },
        ),
      ),
    );
  }
}
