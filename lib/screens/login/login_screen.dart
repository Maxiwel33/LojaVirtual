// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user_app.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: const Text('Entrar'),
          backgroundColor: const Color.fromARGB(255, 9, 27, 39),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: const Text(
                'CRIAR CONTA',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logoMarca(),
              _cardCompleto(),
            ],
          ),
        ),
      ),
    );
  }

  _cardCompleto() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formkey,
        child: Consumer<UserManager>(
          builder: (_, userManager, child) {
            return ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: emailcontroller,
                  enabled: !userManager.loading,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (String email) {
                    if (!emailValid(email.trim())) return 'E-mail Inválido';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passcontroller,
                  enabled: !userManager.loading,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  autocorrect: false,
                  obscureText: true,
                  validator: (String pass) {
                    if (pass.isEmpty || pass.length < 6)
                      // ignore: curly_braces_in_flow_control_structures
                      return 'Senha Inválida';
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Esqueci minha senha'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: userManager.loading
                        ? null
                        : () {
                            if (formkey.currentState.validate()) {
                              userManager.signIn(
                                  userApp: UserApp(
                                    email: emailcontroller.text,
                                    password: passcontroller.text,
                                  ),
                                  onFail: (e) {
                                    scaffoldKey.currentState?.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao entra: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  });
                            }
                          },
                    child: userManager.loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.amber),
                          )
                        : const Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

logoMarca() {
  return SizedBox(
    height: 150,
    child: Image.asset('assets/images/logo.png'),
  );
}
