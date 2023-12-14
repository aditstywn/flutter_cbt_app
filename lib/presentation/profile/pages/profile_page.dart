import 'package:flutter/material.dart';
import 'package:flutter_cbt/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt/data/datasource/auth/auth_local_datasource.dart';

import '../../../core/components/custom_scaffold.dart';
import '../../../data/models/response/auth/auth_response_model.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: false,
      toolbarHeight: 110.0,
      appBarTitle: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Image.network(
              'https://i.pravatar.cc/200',
              width: 64.0,
              height: 64.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),

          FutureBuilder<AuthResponseModel>(
            future: AuthLocalDatasource().getAuthData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: context.deviceWidth - 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        snapshot.data!.user.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {
          //     context.pushAndRemoveUntil(const LoginPage(), (route) => false);
          //   },
          //   icon: Assets.icons.logout.image(width: 24.0),
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          ProfileMenu(
            label: 'Edit Profile',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Help',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Privacy & Policy',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Term of Service',
            onPressed: () {},
          ),
          const SizedBox(height: 16.0),
          ProfileMenu(
            label: 'Logout',
            onPressed: () {
              AuthLocalDatasource().removeAuthData();
              context.pushAndRemoveUntil(const LoginPage(), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
