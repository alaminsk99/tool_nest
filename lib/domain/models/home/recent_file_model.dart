import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

enum FileStatus { processing, completed, opened }
enum RecentFileType { image, pdf }

class RecentFileModel {
  final String path;
  final String name;
  final RecentFileType fileType;
  final FileStatus status;
  final String tab;
  final double? aspectRatio; // <-- NEW

  const RecentFileModel({
    required this.path,
    required this.name,
    required this.fileType,
    required this.status,
    required this.tab,
    this.aspectRatio,
  });

  Map<String, dynamic> toJson() => {
    'path': path,
    'name': name,
    'fileType': fileType.name,
    'status': status.name,
    'tab': tab,
    'aspectRatio': aspectRatio,
  };

  factory RecentFileModel.fromJson(Map<String, dynamic> json) {
    return RecentFileModel(
      path: json['path'],
      name: json['name'],
      fileType: RecentFileType.values.firstWhere(
            (e) => e.name == json['fileType'],
        orElse: () => RecentFileType.pdf,
      ),
      status: FileStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => FileStatus.completed,
      ),
      tab: json['tab'] ?? RecentTabs.downloads,
      aspectRatio: (json['aspectRatio'] as num?)?.toDouble(), // <- handled safely
    );
  }

  RecentFileModel copyWith({
    String? path,
    String? name,
    RecentFileType? fileType,
    FileStatus? status,
    String? tab,
    double? aspectRatio, // <-- NEW
  }) {
    return RecentFileModel(
      path: path ?? this.path,
      name: name ?? this.name,
      fileType: fileType ?? this.fileType,
      status: status ?? this.status,
      tab: tab ?? this.tab,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }
}
