class HomeImage {
  final String status;
  final String url;

  HomeImage({
    required this.status,
    required this.url,
  });

  factory HomeImage.fromJson(Map<String, dynamic> json) {
    return HomeImage(
      status: json['status']?.toString() ?? 'unknown',
      url: json['message']?.toString() ?? '',
    );
  }
}
