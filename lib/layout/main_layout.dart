import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/translator.dart';

import 'news_details.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.breakingNews != null,
          fallback: (BuildContext context) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(28.0),
              child: SafeArea(child: CircularProgressIndicator()),
            ));
          },
          builder: (BuildContext context) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: Stack(
                    children: [
                      breakingNewsFirstImage(context, cubit),
                      buildFirstNewsText(
                          top: MediaQuery.of(context).size.height / 8,
                          right: 200,
                          text: cubit.breakingNews!.articles[0].source!.name ??
                              ''),
                      buildFirstNewsText(
                          top: 150,
                          right: 20,
                          text: cubit.breakingNews!.articles[0].title ?? '',
                          height: 100,
                          width: double.infinity,
                          color: Colors.black26),
                      Positioned(
                        top: 280,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.nextScreen(
                                context: context,
                                screen: NewsDetails(
                                    url: cubit.breakingNews!.articles[0].url ??
                                        ''));
                          },
                          child: Row(
                            children: [
                              Text(
                                ReadMore,
                                style: firstNewsStyle.copyWith(
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                readMoreIcon,
                                size: 28,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        BreakingNews,
                        style: firstNewsStyle.copyWith(
                            fontSize: 25, color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        More,
                        style: firstNewsStyle.copyWith(
                            fontSize: 18, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return breakingNewsWidget(
                              context: context,
                              breakingNews:
                                  cubit.breakingNews!.articles[index]);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 15),
                        itemCount: cubit.breakingNews!.totalResult ?? 0),
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }

  Widget breakingNewsWidget(
      {required BuildContext context, required NewsModelArticle breakingNews}) {
    String date = breakingNews.publishedAt.toString().substring(0, 10);
    int time = int.parse(breakingNews.publishedAt.toString().substring(11, 13));

    String fullDateNow = DateTime.now().toString();
    String dateNow = fullDateNow.substring(0, 10);
    int timeNow = int.parse(fullDateNow.substring(11, 13));

    String postDate = dateNow == date
        ? timeNow == time
            ? nowText
            : '${timeNow - time} $hoursText'
        : date;

    return GestureDetector(
      onTap: () {
        AppCubit.get(context).nextScreen(
            context: context, screen: NewsDetails(url: breakingNews.url ?? ''));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5 * 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 5 * 3,
              height: MediaQuery.of(context).size.width / 5 * 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(breakingNews.image ?? imageNotFoundURL),
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              breakingNews.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.timer_sharp,
                  color: isAppDark ? Colors.white : Colors.black,
                  size: 18,
                ),
                const SizedBox(width: 2),
                Text(
                  postDate,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildFirstNewsText(
      {required String text,
      double top = 180,
      double right = 0,
      double width = 140,
      double height = 45,
      Color color = Colors.white24}) {
    return Positioned(
      // bottom: bottom,
      top: top,
      left: 20,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: firstNewsStyle.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget breakingNewsFirstImage(BuildContext context, AppCubit cubit) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              image: NetworkImage(
                  cubit.breakingNews!.articles[0].image ?? imageNotFoundURL),
              fit: BoxFit.cover),
        ));
  }
}
