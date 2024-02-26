import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              SizedBox(
                height: height * 0.025,
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      // obscuringCharacter: '#',
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    );
                  }),
              SizedBox(
                height: height * 0.035,
              ),
              RoundButton(
                title: 'Login',
                loading: authViewModel.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.toastMessage('Please enter email');
                  } else if (_passwordController.text.isEmpty) {
                    Utils.toastMessage('Please enter password');
                  } else if (_passwordController.text.length < 8) {
                    Utils.toastMessage('Please enter 8 digit password');
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString()
                    };

                    // Map data = {
                    //   'email': 'eve.holt@reqres.in',
                    //   'password': 'cityslicka'
                    // };

                    authViewModel.loginApi(data, context);
                    print('Api hit');
                  }
                },
              ),
              SizedBox(
                height: height * 0.025,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signup);
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}












// body: Center(
//         child: InkWell(
//             onTap: () {
//               // Utils.snackBar('No internet connection', context);

//               Utils.flushBarErrorMessage('No internet connection', context);

//               // Utils.toastMessage("Click me");
//               // Navigator.pushNamed(context, RouteName.home);

//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (_) => const HomeScreen()));
//             },
//             child: const Text('Click')),
//       ),