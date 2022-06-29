part of flutter_apple_music;

class QueueConfiguration {
  List<String> songIds;
  bool overwrite;

  QueueConfiguration(
    this.songIds, {
    this.overwrite = false,
  });

  QueueConfiguration copyWith({
    List<String>? songIds,
    bool? overwrite,
  }) {
    return QueueConfiguration(
      songIds ?? this.songIds,
      overwrite: overwrite ?? this.overwrite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songIds': songIds,
      'replace': overwrite,
    };
  }

  factory QueueConfiguration.fromMap(Map<String, dynamic> map) {
    return QueueConfiguration(
      List<String>.from(map['songIds']),
      overwrite: map['replace'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  // factory QueueConfiguration.fromJson(String source) =>
  //     QueueConfiguration.fromMap(json.decode(source));

  @override
  String toString() => 'QueueConfiguration(songIds: $songIds, replace: $overwrite)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueueConfiguration &&
        listEquals(other.songIds, songIds) &&
        other.overwrite == overwrite;
  }

  @override
  int get hashCode => songIds.hashCode ^ overwrite.hashCode;
}
