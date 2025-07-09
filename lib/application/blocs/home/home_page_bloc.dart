import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  static const int expiryDays = 3;

  HomePageBloc() : super(HomeInitial()) {
    on<LoadRecentFilesEvent>(_onLoadRecentFiles);
    on<ChangeRecentTabEvent>(_onChangeTab);
    on<AddRecentFileEvent>(_onAddRecentFile);
    on<UpdateFileStatusEvent>(_onUpdateFileStatus);
  }

  Future<void> _onLoadRecentFiles(LoadRecentFilesEvent event, Emitter<HomePageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('recentFiles') ?? [];

    final now = DateTime.now();
    final validFiles = stored.map((e) => RecentFileModel.fromJson(jsonDecode(e)))
        .where((f) {
      final file = File(f.path);
      if (!file.existsSync()) return false;
      final modified = file.lastModifiedSync();
      return now.difference(modified).inDays <= expiryDays;
    }).toList()
      ..sort((a, b) => File(b.path).lastModifiedSync().compareTo(File(a.path).lastModifiedSync()));

    final processedFiles = validFiles
        .where((f) => f.tab == RecentTabs.processed)
        .take(10)
        .toList();

    final recentDownloads = await _getRecentDownloads();

    final allFiles = [...processedFiles, ...recentDownloads];
    await _saveFiles(processedFiles);

    emit(HomeLoaded(
      recentFiles: allFiles,
      activeTab: RecentTabs.downloads,
    ));
  }

  Future<void> _onChangeTab(ChangeRecentTabEvent event, Emitter<HomePageState> emit) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;

      if (event.tab == RecentTabs.downloads) {
        final alreadyLoadedDownloads = current.recentFiles
            .where((f) => f.tab == RecentTabs.downloads)
            .toList();

        if (alreadyLoadedDownloads.isNotEmpty) {
          emit(HomeLoaded(
            recentFiles: current.recentFiles,
            activeTab: event.tab,
          ));
        } else {
          final recentDownloads = await _getRecentDownloads();

          final combined = [
            ...current.recentFiles.where((f) => f.tab == RecentTabs.processed),
            ...recentDownloads,
          ];

          emit(HomeLoaded(
            recentFiles: combined,
            activeTab: event.tab,
          ));
        }
      } else {
        emit(HomeLoaded(
          recentFiles: current.recentFiles,
          activeTab: event.tab,
        ));
      }
    }
  }

  Future<void> _onAddRecentFile(AddRecentFileEvent event, Emitter<HomePageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('recentFiles') ?? [];

    final now = DateTime.now();
    final existing = stored.map((e) => RecentFileModel.fromJson(jsonDecode(e)))
        .where((f) {
      final file = File(f.path);
      if (!file.existsSync()) return false;
      final modified = file.lastModifiedSync();
      return now.difference(modified).inDays <= expiryDays && f.path != event.file.path;
    }).toList();

    final updatedProcessed = [event.file, ...existing]
      ..sort((a, b) => File(b.path).lastModifiedSync().compareTo(File(a.path).lastModifiedSync()));

    final filteredProcessed = updatedProcessed
        .where((f) => f.tab == RecentTabs.processed)
        .take(10)
        .toList();

    await _saveFiles(filteredProcessed);

    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      final downloads = current.recentFiles
          .where((f) => f.tab == RecentTabs.downloads)
          .toList();

      final combined = [...filteredProcessed, ...downloads];

      emit(HomeLoaded(recentFiles: combined, activeTab: current.activeTab));
    } else {
      emit(HomeLoaded(
        recentFiles: filteredProcessed,
        activeTab: RecentTabs.processed,
      ));
    }
  }

  Future<void> _onUpdateFileStatus(UpdateFileStatusEvent event, Emitter<HomePageState> emit) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      final updated = current.recentFiles.map((file) {
        return file.path == event.path
            ? file.copyWith(status: event.newStatus)
            : file;
      }).toList();

      await _saveFiles(updated);
      emit(HomeLoaded(recentFiles: updated, activeTab: current.activeTab));
    }
  }

  Future<void> _saveFiles(List<RecentFileModel> files) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = files.map((f) => jsonEncode(f.toJson())).toList();
    await prefs.setStringList('recentFiles', jsonList);
  }

  Future<void> addRecentFile(RecentFileModel file) async {
    add(AddRecentFileEvent(file));
  }

  Future<List<RecentFileModel>> _getRecentDownloads() async {
    final files = await PdfService().getDownloadedPDFs();

    final validFiles = files
        .whereType<File>()
        .where((file) => file.existsSync())
        .toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    final recentModels = validFiles.map((file) => RecentFileModel(
      path: file.path,
      name: file.path.split('/').last,
      fileType: RecentFileType.pdf,
      status: FileStatus.opened,
      tab: RecentTabs.downloads,
    )).take(10).toList();

    return recentModels;
  }
}
