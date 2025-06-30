import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

enum FileStatus { processing, completed, opened }
enum RecentFileType { image, pdf }

class RecentFileModel {
  final String path;
  final String name;
  final RecentFileType fileType;
  final FileStatus status;
  final String tab;

  const RecentFileModel({
    required this.path,
    required this.name,
    required this.fileType,
    required this.status,
    required this.tab,
  });

  Map<String, dynamic> toJson() => {
    'path': path,
    'name': name,
    'fileType': fileType.name,
    'status': status.name,
    'tab': tab,
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
    );
  }

  RecentFileModel copyWith({
    String? path,
    String? name,
    RecentFileType? fileType,
    FileStatus? status,
    String? tab,
  }) {
    return RecentFileModel(
      path: path ?? this.path,
      name: name ?? this.name,
      fileType: fileType ?? this.fileType,
      status: status ?? this.status,
      tab: tab ?? this.tab,
    );
  }
}