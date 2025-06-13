part of 'historic_bloc.dart';

sealed class HistoricState extends Equatable {
  const HistoricState();

  @override
  List<Object> get props => [];
}

final class HistoricInitial extends HistoricState {}

class HistoricLoading extends HistoricState {}

class HistoricLoaded extends HistoricState {
  final List<User> users;
  final bool hasReachedEnd;

  const HistoricLoaded(this.users, {this.hasReachedEnd = false});
}
