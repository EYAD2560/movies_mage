import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'logincupit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginCubit() : super(LoginInitial());

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(LoginWithEmailLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      emit(LoginWithEmailSuccess());
    } catch (e) {
      emit(LoginWithEmailfailed(error: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginWithGoogleLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginCancelled());
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      emit(LoginWithGoogleSuccess());
    } catch (e) {
      emit(LoginWithGooglefailed(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(LoginWithEmailLoading());
    try {
      await _auth.signOut();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      emit(LogoutSuccess());
    } catch (e) {
      emit(Logoutfailed(error: e.toString()));
    }
  }
}
