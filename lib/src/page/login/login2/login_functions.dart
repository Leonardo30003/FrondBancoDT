import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';
import 'package:bancodt/api/api_login.dart';
import 'dialog_builders.dart';
import 'package:bancodt/src/page/home/home_page.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:bancodt/api/api_usuarios.dart';
import 'dart:core';
import 'package:bancodt/src/providers/usuario_provider.dart';
import 'package:bancodt/src/providers/ChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  /// * e.g. [onLogin], [onSignup], [socialLogin], and [onForgotPassword]
  const LoginFunctions(this.context);
  final BuildContext context;

  /// Login action that will be performed on click to action button in login mode.
  Future<String?> onLogin(LoginData loginData) async {
    print(loginData);
    final token =
        await Api.authenticate(context, loginData.email, loginData.password);
    print(token);
    if (token != null) {
      Provider.of<AuthProvider>(context, listen: false)
          .setToken(token['token']);
      Provider.of<UsuarioProvider>(context, listen: false)
          .setUserDetails(Usuario.fromJson(token['user']));

      // Guardar el token y los detalles del usuario
      await Api.saveToken(token['token']);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      // await Api.saveToken(token);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de autenticación')),
      );
    }
  }

  /// Sign up action that will be performed on click to action button in sign up mode.
  Future<String?> onSignup(SignUpData signupData) async {
    print(signupData);
    final usuario = Usuario(
        first_name: signupData.name,
        email: signupData.email,
        password: signupData.password,
        confirm_password: signupData.confirmPassword,
        direccion: "n/n",
        telefono: "n/n",
        documento_identificacion: "n/n",
        imagen: '',
        is_active: true,
        is_staff: true,
        genero: "h",
        last_name: "n/n",
        descripcion: '',
        username: signupData.email);

    try {
      print(usuario.password);
      await UsuarioApi.crearUsuario(usuario);
      print("Usuario Creado");
      Navigator.pushNamed(context, 'login');
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      print('Error al crear usuario: $e');
      return 'Error al crear usuario';
    }

    // final token = await Api.authenticate(signupData.email, signupData.password);
    // if (signupData.password != signupData.confirmPassword) {
    //   return 'The passwords you entered do not match, check again.';
    //}

    return null;
  }

  /// Social login callback example.
  Future<String?> socialLogin(String type) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  /// Action that will be performed on click to "Forgot Password?" text/CTA.
  /// Probably you will navigate user to a page to create a new password after the verification.
  Future<String?> onForgotPassword(String email) async {
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
    //Navigator.of(context).pushNamed('/forgotPass');
    Navigator.of(context).pushNamed('home');
    return null;
  }
}
