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
            label: 'SignIn',
            icon: Icon(
                (currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
            backgroundColor: Colors
                .indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Register',
            icon: Icon(
                (currentScreenIndex == 1) ? Icons.home : Icons.home_outlined),
            backgroundColor: Colors
                .indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
        BottomNavigationBarItem(
            label: 'Homepage',
            icon: Icon(
                (currentScreenIndex == 2) ? Icons.home : Icons.home_outlined),
            backgroundColor: Colors
                .indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
            ),
      ],
      onTap: (value) {
        navigationBarProvider.updateScreenIndex(value);
/*         if (value == 0) {
          context.go('/sign_up');
        } */
        switch (value) {
          case 0:
            context.go('/');
            break;

          case 1:
            context.go('/sign_up');
            break;

          case 2:
            context.go('/home_page');
        }
      },
      selectedItemColor: Colors.amber[800],
    );
  }
}
