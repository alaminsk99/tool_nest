abstract class ImageToPdfEvent {}

class SelectImagesEvent extends ImageToPdfEvent {}

class UpdateSettingsEvent extends ImageToPdfEvent {
  final String pageSize;
  final String orientation;
  final double margin;
  final bool isCustomMargin;

  UpdateSettingsEvent({
    required this.pageSize,
    required this.orientation,
    required this.margin,
    required this.isCustomMargin,
  });
}

class ToggleMarginTypeEvent extends ImageToPdfEvent {
  final bool isCustom;

  ToggleMarginTypeEvent(this.isCustom);
}

class UpdateMarginValueEvent extends ImageToPdfEvent {
  final double margin;

  UpdateMarginValueEvent(this.margin);
}

class ConvertToPdfEvent extends ImageToPdfEvent {}

class ClearSelectedImagesEvent extends ImageToPdfEvent {}