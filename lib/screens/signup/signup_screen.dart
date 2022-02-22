import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user_app.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SignUpScreen({Key key}) : super(key: key);

  final UserApp user = UserApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Criar Conta'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name.isEmpty)
                      // ignore: curly_braces_in_flow_control_structures
                      return 'Campo obrigatório';
                    else if (name.trim().split(' ').length <= 1)
                      return 'Preencha seu nome completo';
                    return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty)
                      return 'Campo obrigatorio';
                    else if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      // ignore: curly_braces_in_flow_control_structures
                      return 'Campo Obrigatorio';
                    // ignore: curly_braces_in_flow_control_structures
                    else if (pass.length < 6) return 'Senha muito curta';
                    return null;
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Repita a Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return 'Campo Obrigatorio';
                    else if (pass.length < 6) return 'Senha muito curta';
                    return null;
                  },
                  onSaved: (pass) => user.confirmPassword = pass,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        if (user.password != user.confirmPassword) {
                          // ignore: deprecated_member_use
                          scaffoldKey.currentState.showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Senha nao coincidem, tente novamente!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        context.read<UserManager>().signUp(
                            userApp: user,
                            onSucess: () {
                              debugPrint('Sucesso');

                              //TODO: POP
                            },
                            onFail: (e) {
                              // ignore: deprecated_member_use
                              scaffoldKey.currentState?.showSnackBar(
                                SnackBar(
                                  content: Text('Falha ao Cadasrtrar: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                      }
                    },
                    child: const Text('Criar Conta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
