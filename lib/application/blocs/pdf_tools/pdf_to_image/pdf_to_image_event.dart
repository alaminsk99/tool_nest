import 'package:equatable/equatable.dart';

abstract class PdfToImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickPdfEvent extends PdfToImageEvent {}

class ConvertPdfEvent extends PdfToImageEvent {
  final int startPage;
  final int endPage;

  ConvertPdfEvent(this.startPage, this.endPage);

  @override
  List<Object?> get props => [startPage, endPage];
}

class ResetPdfToImageEvent extends PdfToImageEvent {}
