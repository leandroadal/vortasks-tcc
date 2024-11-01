import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/shop/not_logged_in_message.dart';
import 'package:vortasks/screens/social/grouptask/all_group_tasks_screen.dart';
import 'package:vortasks/screens/social/widgets/friends_button.dart';
import 'package:vortasks/screens/social/widgets/group_activities_section.dart';
import 'package:vortasks/screens/social/widgets/invitation_list_section.dart';
import 'package:vortasks/screens/social/widgets/today_group_tasks_list.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/social/grouptask/create/create_group_task_screen.dart';
import 'package:vortasks/screens/social/friends/widgets/friend_request_item.dart';
import 'package:vortasks/screens/social/friends/friend_requests_screen.dart';
import 'package:vortasks/screens/social/friends/friends_screen.dart';
import 'package:vortasks/screens/social/grouptask/invites/group_task_requests_screen.dart';
import 'package:vortasks/screens/social/grouptask/widgets/group_task_request_item.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';
import 'package:vortasks/stores/social/group_task_invite_store.dart';
import 'package:vortasks/stores/social/social_store.dart';
import 'package:vortasks/stores/user_store.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final SocialStore _socialStore = GetIt.I<SocialStore>();
  final GroupTaskInviteStore _inviteStore = GetIt.I<GroupTaskInviteStore>();
  final UserStore _userStore = GetIt.I<UserStore>();
  final FriendRequestStore _friendRequestStore = GetIt.I<FriendRequestStore>();

  @override
  void initState() {
    super.initState();
    _socialStore.loadTodayGroupTasks();
    _inviteStore.loadInvites();
    _friendRequestStore.loadFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      appBar: const MyAppBar(title: 'Social'),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (_userStore.isLoggedIn) {
              return _buildLoggedInContent(isSmallScreen, context);
            } else {
              return NotLoggedInMessage(
                message:
                    'Você precisa estar logado para ver suas informações sociais.',
                context: context,
              );
            }
          },
        ),
      ),
      floatingActionButton: _userStore.isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateGroupTaskScreen(),
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            )
          : null,
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
    );
  }

  Widget _buildLoggedInContent(bool isSmallScreen, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FriendsButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FriendsScreen()))),
        const SizedBox(height: 24.0),
        InvitationListSection(
          title: 'Convites de Amizade',
          invites: _friendRequestStore.receivedRequests,
          itemBuilder: (invite) => FriendRequestItem(
              friendInvite: invite,
              isReceived: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary),
          seeMoreAction: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FriendRequestsScreen())),
        ),
        const SizedBox(height: 24.0),
        InvitationListSection(
          title: 'Convites de Tarefas em Grupo',
          invites: _inviteStore.invites
              .where((invite) => invite.status == 'PENDING')
              .toList(),
          itemBuilder: (invite) => GroupTaskRequestItem(
              invite: invite,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary),
          seeMoreAction: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GroupTaskRequestsScreen())),
        ),
        const SizedBox(height: 24.0),
        GroupActivitiesSection(
          onSeeMore: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AllGroupTasksScreen())),
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: TodayGroupTasksList(socialStore: _socialStore),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
