import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());
}
