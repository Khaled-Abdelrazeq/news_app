class NewsModel {
  String? status;
  int? totalResult;
  List<NewsModelArticle> articles = [];

  NewsModel(dynamic data) {
    status = data['status'];
    totalResult = data['totalResults'];

    if (data['articles'] != null) {
      data['articles'].forEach((element) {
        articles.add(NewsModelArticle(element));
      });
    }
  }
}

class NewsModelArticle {
  NewsModelArticleSource? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? image;
  String? publishedAt;

  NewsModelArticle(dynamic data) {
    author = data['author'];
    title = data['title'];
    description = data['description'];
    url = data['url'];
    image = data['urlToImage'];
    publishedAt = data['publishedAt'];

    if (data['source'] != null) {
      source = NewsModelArticleSource(data['source']);
    }
  }
}

class NewsModelArticleSource {
  String? name;

  NewsModelArticleSource(dynamic data) {
    name = data['name'];
  }
}
