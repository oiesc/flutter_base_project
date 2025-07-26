/// Example model for the Home feature
class HomeData {
  final String title;
  final String description;
  final DateTime lastUpdated;
  final bool isActive;

  const HomeData({
    required this.title,
    required this.description,
    required this.lastUpdated,
    this.isActive = true,
  });

  HomeData copyWith({
    String? title,
    String? description,
    DateTime? lastUpdated,
    bool? isActive,
  }) {
    return HomeData(
      title: title ?? this.title,
      description: description ?? this.description,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeData &&
        other.title == title &&
        other.description == description &&
        other.lastUpdated == lastUpdated &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        lastUpdated.hashCode ^
        isActive.hashCode;
  }

  @override
  String toString() {
    return 'HomeData(title: $title, description: $description, lastUpdated: $lastUpdated, isActive: $isActive)';
  }
}
