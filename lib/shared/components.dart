import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/layout/news_details.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/translator.dart';

import 'cubit/cubit.dart';

Widget spaceBetweenTitle({double space = 15}) => SizedBox(width: space);

Widget titleText({
  required String text,
  required Function onTabFunction,
  required int index,
}) =>
    TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: index == currentScreenIndex ? selectedTitleText : Colors.grey,
          fontSize: 20,
          fontWeight:
              index == currentScreenIndex ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () {
        onTabFunction();
      },
    );

Widget dividorTitle({int index = 4, required double width}) => Container(
      height: 2,
      width: width,
      color: index == currentScreenIndex ? selectedTitleText : Colors.grey,
    );

Widget newsElement(
    {required NewsModelArticle news, required BuildContext context}) {
  String date = news.publishedAt.toString().substring(0, 10);
  int time = int.parse(news.publishedAt.toString().substring(11, 13));

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
          context: context, screen: NewsDetails(url: news.url ?? ''));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: news.image.toString() == "null"
                      ? NetworkImage(imageNotFoundURL)
                      : NetworkImage(news.image ?? ''),
                  fit: BoxFit.cover),
            ),
          ),
          spaceBetweenTitle(space: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title ?? '',
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
        ],
      ),
    ),
  );
}

Widget circlearIndicator() => Expanded(
    flex: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
      ],
    ));

Widget newsWidget({required NewsModel? news}) => ConditionalBuilder(
    condition: news != null,
    builder: (context) {
      return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => newsElement(
                  news: news!.articles[index],
                  context: context,
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: news!.totalResult ?? 0),
      );
    },
    fallback: (context) {
      return circlearIndicator();
    });

Widget settingsElement({
  required BuildContext context,
  required bool checkStatus,
  required String trueText,
  required String falseText,
  required IconData trueIconData,
  required IconData falseIconData,
  required Function onTabFunction,
}) =>
    ListTile(
      title: Text(
        checkStatus ? trueText : falseText,
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: Icon(
        checkStatus ? trueIconData : falseIconData,
        color: isAppDark ? Colors.white : Colors.black,
      ),
      onTap: () {
        onTabFunction();
      },
    );
