abstract class ImageToPdfEvent {}

class SelectImagesEvent extends ImageToPdfEvent {}

class UpdateSettingsEvent extends ImageToPdfEvent {
  final String pageSize;
  final String orientation;
  final double margin;

  UpdateSettingsEvent(this.pageSize, this.orientation, this.margin);
}

class ConvertToPdfEvent extends ImageToPdfEvent {}
class ClearSelectedImagesEvent extends ImageToPdfEvent {}

