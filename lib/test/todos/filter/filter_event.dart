
enum FilterType{all,completed ,active}

abstract  class FilterEvent{}





class ChangeFilter extends FilterEvent{
  final FilterType filter;
  ChangeFilter(this.filter);

}