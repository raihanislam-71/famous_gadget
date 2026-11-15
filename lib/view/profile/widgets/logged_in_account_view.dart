import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';
import 'logged_in/account_menu_section.dart';
import 'logged_in/logout_button_card.dart';
import 'logged_in/profile_header_card.dart';
import 'logged_in/settings_menu_section.dart';

class LoggedInAccountView extends StatelessWidget {
  const LoggedInAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<ProfileController>(
        builder: (profile) => ListView(
          padding: const EdgeInsets.only(bottom: 104),
          children: [
            ProfileHeaderCard(profile: profile),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: const [
                  AccountMenuSection(),
                  SizedBox(height: 14),
                  SettingsMenuSection(),
                  SizedBox(height: 14),
                  LogoutButtonCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
