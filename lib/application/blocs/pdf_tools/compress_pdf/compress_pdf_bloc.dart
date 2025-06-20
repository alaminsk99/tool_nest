import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'compress_pdf_event.dart';
part 'compress_pdf_state.dart';

class CompressPdfBloc extends Bloc<CompressPdfEvent, CompressPdfState> {
  CompressPdfBloc() : super(CompressPdfInitial()) {
    on<CompressPdfEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
