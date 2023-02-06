class NewsModel {
  String? status;
  num? totalResults;
  List<Article>? articles=[];

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    totalResults = json["totalResults"];
    if(json["articles"]!=null) {
      json["articles"].forEach((item){
      final Article article=Article.fromJson(item);
      articles!.add(article);
    });
    }
  }
}

class Article {
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;

  Article.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    url = json["url"];
    urlToImage = json["urlToImage"];
    publishedAt = json["publishedAt"];
  }
}
