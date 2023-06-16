import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Método para verificar se o usuário está logado
  bool isUserLoggedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // Método para realizar o login
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Tratar erros de login aqui
      print('Erro de login: $e');
    }
  }

  // Método para realizar o cadastro
  Future<void> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Tratar erros de cadastro aqui
      print('Erro de cadastro: $e');
    }
  }

  // Método para realizar o logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
