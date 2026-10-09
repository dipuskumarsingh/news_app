class CurrentNewsDataModel{
  String? nextPage;
  List<ResultsModel>? results;
  String? status;
  int? totalResults;

  CurrentNewsDataModel({required this.nextPage, required this.results, required this.status, required this.totalResults});

  factory CurrentNewsDataModel.fromJson(Map<String, dynamic>json){
    List<ResultsModel> listOfResult = [];
    for(Map<String,dynamic> eachResultData in json['results'] ){
      listOfResult.add(ResultsModel.fromJson(eachResultData));
    }
    return CurrentNewsDataModel(
        nextPage: json['nextPage'],
        results:  listOfResult,
        status:json['status'] ,
        totalResults:json['totalResults']
    );
  }

}

class ResultsModel {
  String? ai_org;
  String? ai_region;
  String? ai_summary;
  String? ai_tag;
  String? article_id;
  List<dynamic>? category;
  List<dynamic>? country;
  List<dynamic>? creator;
  List<dynamic>? keywords;
  String? content;
  String? datatype;
  String? description;
  bool? duplicate;
  String? fetched_at;
  String? image_url;
  String? language;
  String? link;
  String? pubDate;
  String? pubDateTZ;
  String? sentiment;
  String? sentiment_stats;
  String? source_icon;
  String? source_id;
  String? source_name;
  int? source_priority;
  String? source_url;
  String? title;
  dynamic? video_url;

  ResultsModel({
    required this.ai_org,
    required this.ai_region,
    required this.ai_summary,
    required this.ai_tag,
    required this.article_id,
    required this.category,
    required this.title,
    required this.source_name,
    required this.link,
    required this.source_url,
    required this.country,
    required this.description,
    required this.content,
    required this.creator,
    required this.datatype,
    required this.duplicate,
    required this.fetched_at,
    required this.image_url,
    required this.keywords,
    required this.language,
    required this.pubDate,
    required this.pubDateTZ,
    required this.sentiment,
    required this.sentiment_stats,
    required this.source_icon,
    required this.source_id,
    required this.source_priority,
    required this.video_url,
  });

  factory ResultsModel.fromJson (Map<String, dynamic>json){
    return ResultsModel(
        ai_org: json['ai_org'],
        ai_region: json['ai_region'],
        ai_summary:json['ai_summary'] ,
        ai_tag:json['ai_tag'] ,
        article_id: json['article_id'],
        category: json['category'],
        title: json['title'],
        source_name:json['source_name'] ,
        link:json['link'] ,
        source_url:json['source_url'] ,
        country:json['country'] ,
        description: json['description'],
        content:json['content'] ,
        creator: json['creator'],
        datatype:json['datatype'] ,
        duplicate: json['duplicate'],
        fetched_at: json['fetched_at'],
        image_url: json['image_url'],
        keywords:json['keywords'] ,
        language:json['language'] ,
        pubDate:json['pubDate'] ,
        pubDateTZ: json['pubDateTZ'],
        sentiment: json['sentiment'],
        sentiment_stats: json['sentiment_stats'],
        source_icon: json['source_icon'],
        source_id: json['source_id'],
        source_priority: json['source_priority'],
        video_url: json['video_url']
    );
  }
}
