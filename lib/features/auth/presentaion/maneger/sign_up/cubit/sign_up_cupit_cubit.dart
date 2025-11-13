import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_cupit_state.dart';

class SignUpCubit extends Cubit<SignUpCupitState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignUpCubit() : super(SignUpCupitInitial());

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(SignUpCupitLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      emit(SignUpCupitSuccessed());
    } catch (e) {
      emit(SignUpCupitFailed(error: e.toString()));
    }
  }
}
