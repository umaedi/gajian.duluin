class AppModel {
  final String appId;
  final String latestVersion;
  final bool isCriticalUpdate;
  final String releaseNotes;
  final String downloadUrl;
  final String versionListUrl;

  AppModel({
    required this.appId,
    required this.latestVersion,
    required this.isCriticalUpdate,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.versionListUrl,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      appId: json['appId'] ?? '',
      latestVersion: json['latestVersion'] ?? '',
      isCriticalUpdate: json['isCriticalUpdate'] ?? '',
      releaseNotes: json['releaseNotes'] ?? '',
      downloadUrl: json['downloadUrl'] ?? '',
      versionListUrl: json['versionListUrl'] ?? '',
    );
  }
}
