import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/backup/backup_screen.dart';
import 'package:vortasks/screens/home/resume/widgets/account_icon.dart';
import 'package:vortasks/screens/social/social_screen.dart';
import 'package:vortasks/stores/theme_store.dart';
import 'package:vortasks/stores/user_store.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, this.bottomBar});
  final String title;
  final PreferredSizeWidget? bottomBar;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeStore = GetIt.I<ThemeStore>();

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      leading: IconButton(
        // Movido para a propriedade leading
        icon: Observer(
          builder: (_) {
            switch (themeStore.currentTheme) {
              case ThemeMode.system:
                return const Icon(Icons.brightness_auto);
              case ThemeMode.light:
                return const Icon(Icons.wb_sunny);
              case ThemeMode.dark:
                return const Icon(Icons.nights_stay);
              default:
                return const Icon(Icons.brightness_auto);
            }
          },
        ),
        onPressed: () {
          themeStore.toggleTheme();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.sync),
          onPressed: () async {
            if (GetIt.I<UserStore>().isLoggedIn) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BackupScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Efetue login para realizar a operação de backup",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.people),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SocialScreen()),
            );
          },
        ),
        const AccountIcon(),
      ],
      //backgroundColor: const Color(0xFF2c00a2), // Color(0xFF2c00a2)

      centerTitle: true,
      title: Text(
        title,
      ),
    );
  }
}
