import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/home/resume/widgets/goals/goal_section.dart';
import 'package:vortasks/screens/home/resume/widgets/header_tab.dart';
import 'package:vortasks/screens/home/resume/widgets/profile_card.dart';
import 'package:vortasks/screens/home/resume/widgets/tasks/task_list.dart';
import 'package:vortasks/screens/widgets/my_navigation_rail.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/user_store.dart';

class ResumeTab extends StatefulWidget {
  const ResumeTab({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {
  Timer? _syncTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final UserStore userStore = GetIt.I<UserStore>();

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_handleConnectivityChange);
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    // Verifica se a conexão está disponível
    if (results.any((result) => result != ConnectivityResult.none)) {
      //_startSync(); // Inicia a sincronização se a conexão estiver disponível
    }
  }

  void _startSync() {
    if (userStore.isLoggedIn) {
      _syncTimer = Timer.periodic(const Duration(seconds: 60), (timer) async {
        try {
          await GetIt.I<ProgressStore>().fromRemote();
        } catch (e) {
          print('Erro de sincronização: $e');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyNavigationRail(),
              buildLargeLayout(),
            ],
          );
        } else {
          return buildLayout();
        }
      },
    );
  }

  SingleChildScrollView buildLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTab(pageController: widget.pageController),
            const SizedBox(height: 16.0),
            const ProfileCard(),
            const SizedBox(height: 16),
            const GoalSection(),
            const SizedBox(height: 16),
            const TaskList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Expanded buildLargeLayout() {
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileCard(),
                  SizedBox(height: 16),
                  GoalSection(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderTab(pageController: widget.pageController),
                    const SizedBox(
                      height: 10,
                    ),
                    const TaskList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
