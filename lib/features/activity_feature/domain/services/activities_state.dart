part of 'activities_cubit.dart';

@immutable
abstract class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}
class ActivitiesLoading extends ActivitiesState {}
class ActivitiesDone extends ActivitiesState {}
class ActivitiesUpdated extends ActivitiesState {}
class ActivitiesPlannedUpdated extends ActivitiesState {}
class ActivitiesAdded extends ActivitiesState {}
class ActivitiesPlannedAdded extends ActivitiesState {}
class ActivitiesError extends ActivitiesState {
  final String?error;

  ActivitiesError({this.error});
}
