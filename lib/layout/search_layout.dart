import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchLayout extends StatelessWidget {
  SearchLayout({Key? key}) : super(key: key);

  // Search Controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              SearchBarAnimation(
                textEditingController: searchController,
                searchBoxWidth: MediaQuery.of(context).size.width - 6,
                isOriginalAnimation: false,
                buttonBorderColour: Colors.black45,
                buttonIcon: Icons.search,
                onChanged: (String value) {
                  if (searchController.text.trim().isNotEmpty) {
                    cubit.onSearchButtonClicked(searchText: value);
                  }
                },
                onFieldSubmitted: (String value) {
                  if (searchController.text.trim().isNotEmpty) {
                    cubit.onSearchButtonClicked(searchText: value);
                    searchController.clear();
                  }
                },
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: Text('')),
              newsWidget(news: cubit.searchNews),
            ],
          ),
        );
      },
    );
  }
}
