import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_result_model.dart';

abstract class PdfToImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PdfInitial extends PdfToImageState {}

class PdfPicked extends PdfToImageState {
  final String pdfPath;
  final int pageCount;

  PdfPicked(this.pdfPath, this.pageCount);

  @override
  List<Object?> get props => [pdfPath, pageCount];
}

class PdfConverting extends PdfToImageState {}

class PdfConverted extends PdfToImageState {
  final List<PdfToImageResultModel> results;
  PdfConverted(this.results);
}

class PdfError extends PdfToImageState {
  final String message;

  PdfError(this.message);

  @override
  List<Object?> get props => [message];
}
