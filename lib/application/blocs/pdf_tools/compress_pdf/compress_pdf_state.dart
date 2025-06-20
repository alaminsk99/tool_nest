part of 'compress_pdf_bloc.dart';

abstract class CompressPdfState extends Equatable {
  const CompressPdfState();

  @override
  List<Object?> get props => [];
}

class CompressPdfInitial extends CompressPdfState {}

class CompressPdfLoading extends CompressPdfState {}

class CompressPdfPicked extends CompressPdfState {
  final File file;
  final CompressionLevel level;

  const CompressPdfPicked(this.file, this.level);

  CompressPdfPicked copyWith({
    File? file,
    CompressionLevel? level,
  }) {
    return CompressPdfPicked(
      file ?? this.file,
      level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [file, level];
}


class CompressPdfSuccess extends CompressPdfState {
  final CompressedPdfModel compressedPdf;

  const CompressPdfSuccess(this.compressedPdf);

  @override
  List<Object?> get props => [compressedPdf];
}

class CompressPdfError extends CompressPdfState {
  final String message;

  const CompressPdfError(this.message);

  @override
  List<Object?> get props => [message];
}
