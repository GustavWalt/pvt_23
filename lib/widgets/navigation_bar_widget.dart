import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/navigation_bar_provider.dart';
import 'package:go_router/go_router.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBarProvider = Provider.of<NavigationBarProvider>(context);
    int currentScreenIndex = navigationBarProvider.fetchCurrentScreenIndex;
    return BottomNavigationBar(
      currentIndex: currentScreenIndex,
      items: [
        BottomNavigationBarItem(
            label: 'Homepage',
            icon: Icon(
                (currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
            backgroundColor: Colors
                .black // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
                (currentScreenIndex == 0) ? Icons.man : Icons.man_outlined),
            backgroundColor: Colors
                .black // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Register',
            icon: Icon((currentScreenIndex == 1)
                ? Icons.app_registration
                : Icons.app_registration_outlined),
            backgroundColor: Colors
                .black // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(
                (currentScreenIndex == 2) ? Icons.chat : Icons.chat_outlined),
            backgroundColor: Colors
                .black // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Groups',
            icon: Icon(
                (currentScreenIndex == 2) ? Icons.group : Icons.group_outlined),
            backgroundColor: Colors
                .black // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
      ],
      onTap: (value) {
        navigationBarProvider.updateScreenIndex(value);
        switch (value) {
          case 0:
            context.go('/home_page');
            break;

          case 1:
            context.go('/profile_page');
            break;

          case 2:
            context.go('/register_page');
            break;

          case 3:
            context.go('/chat_list_page');
            break;

          case 4:
            context.go('/group_page');
            break;
        }
      },
      selectedItemColor: Colors.red[500],
    );
  }
}
