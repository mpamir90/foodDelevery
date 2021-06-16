part of 'homeview_bloc.dart';

@immutable
abstract class HomeviewState {}

class HomeviewInitial extends HomeviewState {}

//getToko
class OnGetTokoLoading extends HomeviewState{}

class OnGetTokoSucceded extends HomeviewState{
  final Map<String, dynamic>? data;
  OnGetTokoSucceded(this.data);
}

class OnGetTokoError extends HomeviewState{
  final String errorMesage;
  OnGetTokoError(this.errorMesage);
}