import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fashon_app/screens/main/component/home.dart';
import 'package:fashon_app/screens/main/view_model/main_view_model.dart';
import 'package:fashon_app/screens/search/search_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class MainWrapper extends ConsumerWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainViewModelProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: viewModel.getSelectedNavigationItem(),
          selectedItemColor: Colors.orange,
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.home, color: Colors.orange),
              label: "Home",
              icon: InkWell(
                onTap: () {
                  viewModel.setSelectedNavigationItem(0);
                },
                child: const Icon(Icons.home, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.search, color: Colors.orange),
              label: "Search",
              icon: InkWell(
                onTap: () {
                  viewModel.setSelectedNavigationItem(1);
                },
                child: const Icon(Icons.search, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.explore, color: Colors.orange),
              label: "Explore",
              icon: InkWell(
                onTap: () {
                  viewModel.setSelectedNavigationItem(2);
                },
                child: const Icon(
                  Icons.explore,
                  color: Colors.black,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.settings, color: Colors.orange),
              label: "Settings",
              icon: InkWell(
                onTap: () {
                  viewModel.setSelectedNavigationItem(3);
                },
                child: const Icon(Icons.settings, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.mail, color: Colors.orange),
              label: "Mail",
              icon: InkWell(
                onTap: () {
                  viewModel.setSelectedNavigationItem(4);
                },
                child: const Icon(Icons.mail, color: Colors.black),
              ),
            ),
          ]),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: FadeIn(
          child: Text(
            viewModel.isOnSearchPage ? "Search" : "Home",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (viewModel.isOnSearchPage) {
                viewModel.setOnIsSearchMode(true);
              } else {
                viewModel.setOnIsSearchMode(false);
              }
            },
            icon: Icon(
              viewModel.isOnSearchPage
                  ? LineIcons.searchMinus
                  : LineIcons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LineIcons.shoppingBag,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: viewModel.isOnSearchPage ? const SearchPage() : const Home(),
    );
  }
}
