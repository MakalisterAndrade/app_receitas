import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_receitas/View/SignUpView.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _goToRegister() {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/user.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: context.mediaQueryPadding.top),
            SizedBox(
              height: context.height * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Text(
                        'Entre e ache a receita perfeita',
                        style: TextStyle(
                          color: Colors.red, // Cor desejada
                          fontSize: 24, // Tamanho do texto
                          fontWeight: FontWeight.bold, // Peso da fonte
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                          elevation: MaterialStateProperty.all<double>(0.5),
                          // Outras propriedades de estilo que você deseja definir
                        ),
                        onPressed: _loginUser,
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _loginWithGoogle,
                            child: SvgPicture.asset(
                              "assets/google_logo.svg",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: _goToRegister,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "Não tem uma conta? ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: "Cadastre-se aqui",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginWithGoogle() async {
    try {
      EasyLoading.show(status: 'Carregando...');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Autenticação com o Google bem-sucedida
        Get.offNamed('/splash');
        _showSuccessSnackbar();
      } else {
        // Autenticação com o Google falhou
        _showErrorSnackbar();
      }
    } catch (e) {
      // Ocorreu um erro ao autenticar com o Google
      _showErrorSnackbar();
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _loginUser() async {
    try {
      EasyLoading.show(status: 'Carregando...');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Login realizado com sucesso
      Get.offNamed('/splash');
      _showSuccessSnackbar();
    } catch (e) {
      // Ocorreu um erro ao fazer o login
      _showErrorSnackbar();
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _showSuccessSnackbar() {
    Fluttertoast.showToast(
      msg: 'Login realizado com sucesso',
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void _showErrorSnackbar() {
    Fluttertoast.showToast(
      msg: 'Erro ao fazer login',
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
