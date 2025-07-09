import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

import 'image_resizer_event.dart';
import 'image_resizer_state.dart';

class ImageResizeBloc extends Bloc<ImageResizeEvent, ImageResizeState> {
  ImageResizeBloc() : super(ImageResizeInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<UpdateWidthEvent>(_onUpdateWidth);
    on<UpdateHeightEvent>(_onUpdateHeight);
    on<UpdateAspectRatioLockEvent>(_onUpdateAspectRatioLock);
    on<ResizeImageEvent>(_onResizeImage);
    on<ResetResizeStateEvent>(_onResetResizeState);
  }

  void _onPickImage(PickImageEvent event, Emitter<ImageResizeState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded != null) {
        emit(ImageResizeLoaded(
          originalImage: decoded,
          imageBytes: bytes,
          width: decoded.width,
          height: decoded.height,
          lockAspectRatio: true,
        ));
      } else {
        emit(ImageResizeError('Failed to decode image.'));
      }
    } else {
      emit(ImageResizeError('No image selected.'));
    }
  }

  void _onUpdateWidth(UpdateWidthEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      int newHeight = current.height;

      if (current.lockAspectRatio) {
        newHeight = (current.originalImage.height * event.width / current.originalImage.width).round();
      }

      emit(current.copyWith(width: event.width, height: newHeight));
    }
  }

  void _onUpdateHeight(UpdateHeightEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      int newWidth = current.width;

      if (current.lockAspectRatio) {
        newWidth = (current.originalImage.width * event.height / current.originalImage.height).round();
      }

      emit(current.copyWith(width: newWidth, height: event.height));
    }
  }

  void _onUpdateAspectRatioLock(UpdateAspectRatioLockEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      emit(current.copyWith(lockAspectRatio: event.lock));
    }
  }

  Future<void> _onResizeImage(ResizeImageEvent event, Emitter<ImageResizeState> emit) async {
    final current = state;
    if (current is ImageResizeLoaded) {
      emit(ImageResizeLoading());

      final resized = img.copyResize(
        current.originalImage,
        width: current.width,
        height: current.height,
      );
      final bytes = Uint8List.fromList(img.encodeJpg(resized));
      // Save to temporary file
      final dir = await getTemporaryDirectory();
      final fileName = 'resized_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath)..writeAsBytesSync(bytes);

      emit(ImageResizeDone(
        resizedBytes: bytes,
        width: current.width,
        height: current.height,
      ));

      final aspectRatio = await PdfService().detectAspectRatio(file.path, RecentFileType.image);
      // Add to recent processed files
      final recentImage = RecentFileModel(
        path: file.path,
        name: fileName,
        fileType: RecentFileType.image,
        status: FileStatus.completed,
        tab: RecentTabs.processed,
        aspectRatio: aspectRatio,
      );

      event.context.read<HomePageBloc>().add(AddRecentFileEvent(recentImage));
    }
  }
  void _onResetResizeState(ResetResizeStateEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeDone) {
      // Reconstruct ImageResizeLoaded with previous data
      final originalImage = img.decodeImage(current.resizedBytes);
      if (originalImage != null) {
        emit(ImageResizeLoaded(
          originalImage: originalImage,
          imageBytes: current.resizedBytes,
          width: current.width,
          height: current.height,
          lockAspectRatio: true,
        ));
      } else {
        emit(ImageResizeError('Failed to restore image state.'));
      }
    }
  }


}
