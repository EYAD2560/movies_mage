part of 'sign_up_cupit_cubit.dart';

@immutable
sealed class SignUpCupitState {}

final class SignUpCupitInitial extends SignUpCupitState {}

final class SignUpCupitLoading extends SignUpCupitState {}

final class SignUpCupitSuccessed extends SignUpCupitState {}

final class SignUpCupitFailed extends SignUpCupitState {
  final String error;

  SignUpCupitFailed({required this.error});
}
