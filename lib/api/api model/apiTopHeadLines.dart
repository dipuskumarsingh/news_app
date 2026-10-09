/*
class MainDataModel{
  List<DataModel>? data;
  String? request_id;
  String? status;

  MainDataModel({required this.data, required this.request_id, required this.status});
  factory MainDataModel.fromJson(Map<String,dynamic>json){
    List<DataModel> listOfData = [];
    for(Map<String,dynamic> eachListOfData in json['data']){
      listOfData.add(DataModel.fromJson(eachListOfData));
    }
    return MainDataModel(
        data: listOfData,
        request_id:  json['request_id'],
        status: json['status']
    );
  }
}

class DataModel {
  String? article_id;
  List<String>? authors;
  String? link;
  String? photo_url;
  String? published_datetime_utc;
  List<String>? related_topics;
  String? snippet;
  String? source_favicon_url;
  String? source_logo_url;
  String? source_name;
  String? source_publication_id;
  String? story_id;
  List<SubArticlesModel>? sub_articles;
  String? thumbnail_url;
  String? title;

  DataModel({
    required this.article_id,
    required this.authors,
    required this.link,
    required this.photo_url,
    required this.published_datetime_utc,
    required this.related_topics,
    required this.snippet,
    required this.source_favicon_url,
    required this.source_logo_url,
    required this.source_name,
    required this.source_publication_id,
    required this.story_id,
    required this.thumbnail_url,
    required this.title,
    required this.sub_articles,
  });
  
  factory DataModel.fromJson(Map<String,dynamic>json){
    List<SubArticlesModel> listOfArticle = [];
    for(Map<String,dynamic> eachListOfArticle in json['sub_articles']){
      listOfArticle.add(SubArticlesModel.fromJson(eachListOfArticle));
    }
    return DataModel(
        article_id: json['article_id'],
        authors: json['authors'],
        link: json['link'],
        photo_url:json['photo_url'] ,
        published_datetime_utc:json['published_datetime_utc'] ,
        related_topics:json['related_topics'] ,
        snippet: json['snippet'],
        source_favicon_url:json['source_favicon_url'],
        source_logo_url: json['source_logo_url'],
        source_name: json['source_name'],
        source_publication_id: json['source_publication_id'],
        story_id: json['story_id'],
        thumbnail_url: json['thumbnail_url'],
        title: json['title'],
        sub_articles: listOfArticle,
    );
  }
}

class SubArticlesModel {
  String? article_id;
  List<String>? authors;
  String? link;
  String? photo_url;
  String? published_datetime_utc;
  List<RelatedTopicsModel>? related_topics;
  String? source_favicon_url;
  String? source_logo_url;
  String? source_name;
  String? source_publication_id;
  String? source_url;
  String? thumbnail_url;
  String? title;

  SubArticlesModel({
    required this.article_id,
    required this.authors,
    required this.link,
    required this.photo_url,
    required this.published_datetime_utc,
    required this.related_topics,
    required this.source_favicon_url,
    required this.source_logo_url,
    required this.source_name,
    required this.source_publication_id,
    required this.source_url,
    required this.thumbnail_url,
    required this.title,
  });
  factory SubArticlesModel.fromJson(Map<String, dynamic> json) {
    List<RelatedTopicsModel> mRelatedTopicsData = [];
    for (Map<String, dynamic> eachTopics in json['related_topics']) {
      mRelatedTopicsData.add(RelatedTopicsModel.fromJson(eachTopics));
    }
    return SubArticlesModel(
      article_id: json['article_id'],
      authors: json['authors'],
      link: json['link'],
      photo_url: json['photo_url'],
      published_datetime_utc: json['published_datetime_utc'],
      related_topics: mRelatedTopicsData,
      source_favicon_url: json['source_favicon_url'],
      source_logo_url: json['source_logo_url'],
      source_name: json['source_name'],
      source_publication_id: json['source_publication_id'],
      source_url: json['source_url'],
      thumbnail_url: json['thumbnail_url'],
      title: json['title'],
    );
  }
}

class RelatedTopicsModel {
  String? topic_id;
  String? topic_name;

  RelatedTopicsModel({required this.topic_id, required this.topic_name});
  factory RelatedTopicsModel.fromJson(Map<String, dynamic> json) {
    return RelatedTopicsModel(
      topic_id: json['topic_id'],
      topic_name: json['topic_name'],
    );
  }
}

class TopHeadLinesModel {}
*/
