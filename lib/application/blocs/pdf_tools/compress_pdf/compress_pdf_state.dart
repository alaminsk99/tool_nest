part of 'compress_pdf_bloc.dart';

sealed class CompressPdfState extends Equatable {
  const CompressPdfState();
}

final class CompressPdfInitial extends CompressPdfState {
  @override
  List<Object> get props => [];
}
