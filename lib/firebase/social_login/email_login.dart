import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

createWithEmail({required String email, required String password}) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      userCredential.user?.sendEmailVerification();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showToast('비밀번호 보안이 취약합니다.');
    } else if (e.code == 'email-already-in-use') {
      //TODO: 이미 가입되었으면 signIn 하기
      showToast('이미 가입된 이메일 계정입니다.');
    }
  } catch (e) {
    print(e);
  }
}
