import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/screens/tasks/add_task_screen.dart';
import 'package:vortasks/screens/home/resume/resume_tab.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/home/statistics/statistics_tab.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        pageViewItem(isSmallScreen, ResumeTab(pageController: _pageController)),
        pageViewItem(
            isSmallScreen,
            StatisticsTab(
              pageController: _pageController,
            ))
      ],
    );
  }

  Scaffold pageViewItem(bool isSmallScreen, Widget tab) {
    var productivityColor = Theme.of(context).brightness == Brightness.light
        ? const Color(0xFF3674ef)
        : const Color(0xFF0D47A1);
    final leisureColor = Theme.of(context).brightness == Brightness.light
        ? const Color.fromARGB(255, 206, 109, 186)
        : const Color(0xFF9949de);

    return Scaffold(
      appBar: const MyAppBar(title: 'Vortasks'),
      body: tab,
      floatingActionButton: isSmallScreen
          ? SpeedDial(
              overlayOpacity: 0.4,
              overlayColor: Colors.black,
              useRotationAnimation: true,
              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.mood,
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(255, 206, 109, 186)
                        : const Color(0xFF9949de),
                  ),
                  backgroundColor: Colors.white,
                  label: 'Bem-estar',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: leisureColor,
                  ),
                  labelBackgroundColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTaskScreen(
                          title: 'Aumentar o Bem-estar',
                          type: TaskType.WELL_BEING,
                        ),
                      ),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.task,
                    color: productivityColor,
                  ),
                  backgroundColor: Colors.white,
                  label: 'Produtividade',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: productivityColor,
                  ),
                  labelBackgroundColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTaskScreen(
                                title: 'Aumentar a Produtividade',
                                type: TaskType.PRODUCTIVITY,
                              )),
                    );
                  },
                ),
              ],
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
    );
  }
}
