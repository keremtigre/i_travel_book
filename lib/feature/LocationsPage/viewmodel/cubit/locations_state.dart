part of 'locations_cubit.dart';

@immutable
abstract class LocationsState {}

class LocationsInitial extends LocationsState {
  LocationsInitial();
}

class LocationsLoaded extends LocationsState {
  LocationsLoaded();
}
