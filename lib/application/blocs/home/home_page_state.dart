part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomePageState {}

class HomeLoaded extends HomePageState {
  final List<RecentFileModel> recentFiles;
  final String activeTab;

  const HomeLoaded({
    required this.recentFiles,
    this.activeTab = RecentTabs.downloads,
  });

  @override
  List<Object?> get props => [recentFiles, activeTab];
}