class BlogModel {
  final String id;
  final int categoryId;
  final String title;
  final int headline;
  final String slug;
  final String tags;
  final String content;
  final String keyword;
  final String description;
  final String imgUrl;
  final String contentCover;
  final int viewer;
  final String date;

  BlogModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.headline,
    required this.slug,
    required this.tags,
    required this.content,
    required this.keyword,
    required this.description,
    required this.imgUrl,
    required this.contentCover,
    required this.viewer,
    required this.date,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      categoryId: json['category_id'] ?? 0,
      title: json['title'] ?? '',
      headline: json['headline'] ?? 0,
      slug: json['slug'] ?? '',
      tags: json['tags'] ?? '',
      content: json['content'] ?? '',
      keyword: json['keyword'] ?? '',
      description: json['description'] ?? '',
      imgUrl: json['img'] ?? '',
      contentCover: json['content_cover'] ?? '',
      viewer: json['viewer'] ?? 0,
      date: json['date'] ?? '',
    );
  }
}
