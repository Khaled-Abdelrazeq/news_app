import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class DiscoverLayout extends StatelessWidget {
  const DiscoverLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Column(
          children: [
            // Title Row
            Container(
              height: 50,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    AppCubit cubit = AppCubit.get(context);
                    return titleText(
                        text: screenListTitle[index],
                        onTabFunction: () {
                          cubit.selectScreen(index);
                          switch (index) {
                            case 0:
                              cubit.getGeneralNews();
                              break;
                            case 1:
                              cubit.getSportsNews();
                              break;
                            case 2:
                              cubit.getTechnologyNews();
                              break;
                            case 3:
                              cubit.getScienceNews();
                              break;
                            case 4:
                              cubit.getHealthNews();
                              break;
                            case 5:
                              cubit.getBusinessNews();
                              break;
                            case 6:
                              cubit.getEntertainmentNews();
                              break;
                          }
                        },
                        index: index);
                  },
                  separatorBuilder: (context, index) => spaceBetweenTitle(),
                  itemCount: screensList.length),
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 0,
              //         text: businessText,
              //         onTabFunction: () {
              //           cubit.selectScreen(0);
              //         }),
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 1,
              //         text: sportsText,
              //         onTabFunction: () {
              //           cubit.selectScreen(1);
              //           cubit.getSportsNews();
              //         }),
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 2,
              //         text: scienceText,
              //         onTabFunction: () {
              //           cubit.selectScreen(2);
              //           cubit.getScienceNews();
              //         }),
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 2,
              //         text: scienceText,
              //         onTabFunction: () {
              //           cubit.selectScreen(2);
              //           cubit.getScienceNews();
              //         }),
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 3,
              //         text: scienceText,
              //         onTabFunction: () {
              //           cubit.selectScreen(2);
              //           cubit.getScienceNews();
              //         }),
              //     spaceBetweenTitle(),
              //     titleText(
              //         index: 2,
              //         text: scienceText,
              //         onTabFunction: () {
              //           cubit.selectScreen(2);
              //           cubit.getScienceNews();
              //         }),
              //     spaceBetweenTitle(),
              //   ],
              // ),
            ),
            // Line under title
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31.0),
                  child: dividorTitle(width: double.infinity),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spaceBetweenTitle(space: 32),
                    dividorTitle(index: 0, width: 80),
                    spaceBetweenTitle(space: 45),
                    dividorTitle(index: 1, width: 60),
                    spaceBetweenTitle(space: 45),
                    dividorTitle(index: 2, width: 67),
                    spaceBetweenTitle(space: 25),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            screensList[currentScreenIndex],
          ],
        );
      },
    );
  }
}
