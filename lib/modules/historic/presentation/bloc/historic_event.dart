part of 'historic_bloc.dart';

sealed class HistoricEvent extends Equatable {
  const HistoricEvent();

  @override
  List<Object> get props => [];
}

class LoadHistoryInitial extends HistoricEvent {}

class LoadMoreHistoryRequested extends HistoricEvent {}
