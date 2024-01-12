import 'package:flutter/material.dart';
import 'package:interview_mobile_app/pages/phone/home/home_page.dart';
import 'package:interview_mobile_app/resources/colors.dart';
import '../../pages.dart';
import '../../../blocs/blocs.dart';

import '../../../core/core.dart';
import '../../../gen/assets.gen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseStateNoBloc<MainPage> {

  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(), // TODO: Replace with Home Page
      Container(), // TODO: Replace with Store Page
      Container(), // TODO: Replace with Feed Page
      Container(), // TODO: Replace with Feed Page
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onIndexChanged,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.grey),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.primary,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Assets.images.svg.iconHomePrimaryInactive.svg(),
            activeIcon: Assets.images.svg.iconHomePrimaryActive.svg(),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.svg.iconTicketPrimaryInactive.svg(),
            activeIcon: Assets.images.svg.iconTicketPrimaryActive.svg(),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.svg.iconFavouritePrimaryInactive.svg(),
            activeIcon: Assets.images.svg.iconTicketPrimaryActive.svg(),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Assets.images.svg.iconAccountPrimaryInactive.svg(),
            activeIcon: Assets.images.svg.iconAccountPrimaryActive.svg(),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onIndexChanged(int index) {
    if (index == _currentIndex) return;
    if (index < 0 || index >= _pages.length) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
