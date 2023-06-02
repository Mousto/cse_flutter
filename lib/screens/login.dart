import 'package:flutter/material.dart';

//shortcut pour créer un widget est stl
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _pwdFocusNode = FocusNode();

  var _enteredEmail = '';
  var _enteredPwd = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  var _isObscure = true; //Permet de toogle la visibilité du pwd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saisir un Email.';
                  }
                  return null;
                },
                //Fonction de Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                onSaved: (newValue) {
                  _enteredEmail = newValue!;
                },
                decoration: const InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                focusNode: _pwdFocusNode,
                obscureText: _isObscure,
                controller: _pwdController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Saisir un mot de passe valide.';
                  }
                  return null;
                },
                //Fonction de onSaved Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                onSaved: (newValue) {
                  _enteredPwd = newValue!;
                },
                decoration: InputDecoration(
                  label: const Text('Mot De Passe'),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
