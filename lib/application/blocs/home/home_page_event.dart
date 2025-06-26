part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecentFilesEvent extends HomePageEvent {}

class ChangeRecentTabEvent extends HomePageEvent {
  final String tab;
  const ChangeRecentTabEvent(this.tab);

  @override
  List<Object?> get props => [tab];
}

class AddRecentFileEvent extends HomePageEvent {
  final RecentFileModel file;
  const AddRecentFileEvent(this.file);

  @override
  List<Object?> get props => [file];
}

class UpdateFileStatusEvent extends HomePageEvent {
  final String path;
  final FileStatus newStatus;
  const UpdateFileStatusEvent(this.path, this.newStatus);

  @override
  List<Object?> get props => [path, newStatus];
}