import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';






class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState(FilterType.all)) {
    on<ChangeFilter>((event, emit) {
      emit(FilterState(event.filter));
    });
  }
}
