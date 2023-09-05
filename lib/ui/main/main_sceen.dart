import 'package:flutter/material.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/language/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pageDetail = [
      // {
      //   "page": const LandingPageScreen(),
      //   "title": "",
      // },
      // {
      //   "pageName": const FavoriteTasksScreen(),
      //   "title": AppLocalizations.of(context).translate('favoritetasks')
      // },
      // {
      //   "pageName": const CompletedTasksScreen(),
      //   "title": AppLocalizations.of(context).translate('completedtasks')
      // },
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        child: NavigationBar(
          selectedIndex: _selectedPage,
          onDestinationSelected: (value) => setState(() {
            _selectedPage = value;
          }),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home,), label: "Lable"),
            NavigationDestination(
                icon: Icon(Icons.message,), label: "Lable"),
          ],
        ),
      ),
    );
  }
}
