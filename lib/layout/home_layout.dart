import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/search_layout.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
// Search Controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          AppCubit cubit = AppCubit.get(context);
          return currentLayoutIndex == 1
              ? Scaffold(
                  appBar: AppBar(
                    actions: [
                      SearchBarAnimation(
                        textEditingController: searchController,
                        searchBoxWidth: MediaQuery.of(context).size.width - 6,
                        isOriginalAnimation: false,
                        buttonBorderColour: Colors.black45,
                        buttonIcon: Icons.search,
                        onFieldSubmitted: (String value) {
                          if (searchController.text.trim().isNotEmpty) {
                            cubit.onSearchButtonClicked(searchText: value);
                            searchController.clear();
                            cubit.nextScreen(
                                context: context, screen: SearchLayout());
                          }
                        },
                      ),
                    ],
                    title: Text(screenTitle[currentScreenIndex]),
                  ),
                  bottomNavigationBar: buildBottomNavigationBar(cubit),
                  body: layoutList[currentLayoutIndex])
              : Scaffold(
                  bottomNavigationBar: buildBottomNavigationBar(cubit),
                  body: layoutList[currentLayoutIndex]);
        });
  }

  BottomNavigationBar buildBottomNavigationBar(AppCubit cubit) {
    return BottomNavigationBar(
      currentIndex: currentLayoutIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
      onTap: (index) {
        cubit.selectLayout(index);
      },
    );
  }
}
