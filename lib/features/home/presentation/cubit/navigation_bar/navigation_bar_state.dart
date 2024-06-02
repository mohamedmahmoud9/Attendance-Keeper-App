part of 'navigation_bar_cubit.dart';

class NavigationBarState extends Equatable {
  final int currentTab;

  const NavigationBarState({required this.currentTab});

  @override
  List<Object> get props => [currentTab];
}
