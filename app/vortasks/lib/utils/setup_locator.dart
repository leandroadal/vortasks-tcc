import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/stores/shop/cart_store.dart';
import 'package:vortasks/services/notification_service.dart';
import 'package:vortasks/stores/backup/backup_store.dart';
import 'package:vortasks/stores/shop/purchased_items_store.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';
import 'package:vortasks/stores/social/friend_store.dart';
import 'package:vortasks/stores/social/group_task_invite_store.dart';
import 'package:vortasks/stores/social/group_task_store.dart';
import 'package:vortasks/stores/theme_store.dart';
import 'package:vortasks/stores/user_data/goals/goal_history_store.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';
import 'package:vortasks/stores/user_data/level_store.dart';
import 'package:vortasks/stores/auth/login_store.dart';
import 'package:vortasks/stores/auth/logout_store.dart';
import 'package:vortasks/stores/page_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/shop/shop_store.dart';
import 'package:vortasks/stores/auth/signup_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_level_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/social/social_store.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';
import 'package:vortasks/stores/user_data/achievement/achievement_store.dart';
import 'package:vortasks/stores/user_data/check_in/checkin_store.dart';
import 'package:vortasks/stores/user_store.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setupGetIt() async {
  GetIt.I.registerSingleton<PurchasedItemsStore>(PurchasedItemsStore());
  GetIt.I.registerSingleton<GoalHistoryStore>(GoalHistoryStore());
  GetIt.I.registerSingleton<GroupTaskInviteStore>(GroupTaskInviteStore());
  GetIt.I.registerSingleton<ThemeStore>(ThemeStore());
  GetIt.I.registerSingleton<FriendStore>(FriendStore());
  GetIt.I.registerSingleton<FriendRequestStore>(FriendRequestStore());
  GetIt.I.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);
  GetIt.I.registerSingleton<NotificationService>(NotificationService());
  GetIt.I.registerSingleton<SocialStore>(SocialStore());
  GetIt.I.registerSingleton<CheckInStore>(CheckInStore());
  GetIt.I.registerSingleton<AchievementStore>(AchievementStore());
  GetIt.I.registerSingleton<CartStore>(CartStore());

  GetIt.I.registerSingleton<LocalStorage>(LocalStorage());
  GetIt.I.registerSingleton<TaskFormStore>(TaskFormStore());
  GetIt.I.registerSingleton<UserStore>(UserStore());

  GetIt.I.registerSingleton<LogoutStore>(LogoutStore());
  GetIt.I.registerSingleton<SignUpStore>(SignUpStore());
  GetIt.I.registerSingleton<PageStore>(PageStore());
  GetIt.I.registerSingleton<SkillStore>(SkillStore());
  GetIt.I.registerSingleton<SellStore>(SellStore());
  GetIt.I.registerSingleton<LevelStore>(LevelStore());
  GetIt.I.registerSingleton<SkillLevelStore>(SkillLevelStore());
  GetIt.I.registerSingleton<GoalsStore>(GoalsStore());
  GetIt.I.registerSingleton<LoginStore>(LoginStore());
  GetIt.I.registerSingleton<ProgressStore>(ProgressStore());
  GetIt.I.registerSingleton<ShopStore>(ShopStore());
  GetIt.I.registerSingleton<GroupTaskStore>(GroupTaskStore());

  GetIt.I.registerSingleton<TaskStore>(
      TaskStore()); // level e foals precisam ser iniciados antes
  GetIt.I.registerSingleton<BackupStore>(BackupStore());
}
