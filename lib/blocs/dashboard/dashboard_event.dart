part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetProductByCategory extends DashboardEvent {
  final String id;

  GetProductByCategory({this.id});

  @override
  List<Object> get props => [id];
}

class GetApiDashboardEvent extends DashboardEvent {}