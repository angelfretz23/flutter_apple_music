part of flutter_apple_music;

class QueueConfiguration {
  List<String> storeIds;
  bool overwrite;

  QueueConfiguration(
    this.storeIds, {
    this.overwrite = false,
  });

  QueueConfiguration copyWith({
    List<String>? songIds,
    bool? overwrite,
  }) {
    return QueueConfiguration(
      songIds ?? this.storeIds,
      overwrite: overwrite ?? this.overwrite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeIds': storeIds,
      'overwrite': overwrite,
    };
  }

  factory QueueConfiguration.fromMap(Map<String, dynamic> map) {
    return QueueConfiguration(
      List<String>.from(map['storeIds']),
      overwrite: map['overwrite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  // factory QueueConfiguration.fromJson(String source) =>
  //     QueueConfiguration.fromMap(json.decode(source));

  @override
  String toString() =>
      'QueueConfiguration(storeIds: $storeIds, overwrite: $overwrite)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueueConfiguration &&
        listEquals(other.storeIds, storeIds) &&
        other.overwrite == overwrite;
  }

  @override
  int get hashCode => storeIds.hashCode ^ overwrite.hashCode;
}
