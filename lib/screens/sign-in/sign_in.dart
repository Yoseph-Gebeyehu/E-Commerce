import 'package:e_commerce/screens/forgot-password/forgot_password.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showPassword = true;
  bool isSignIn = true;

  void signUserUp() async {
    context.read<AuthenticationBloc>().add(SignupButtonEvent(
          email: emailController.text,
          password: passwordController.text,
          userName: 'asdfads',
        ));
  }

  void signUserIn() async {
    context.read<AuthenticationBloc>().add(SigninButtonEvent(
          email: emailController.text,
          password: passwordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: deviceSize.height * 0.4,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200.0),
                        ),
                      ),
                      child: Image.asset(
                        'assets/mac_image.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: deviceSize.width * 0.5,
                      left: deviceSize.width * 0.2,
                      top: deviceSize.height * 0.35,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSignIn ? Colors.green : Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (isSignIn == false) {
                              setState(() {
                                passwordController.text = '';
                                emailController.text = '';
                                isSignIn = true;
                              });
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: isSignIn ? Colors.white : Colors.green,
                              fontSize: deviceSize.width * 0.036,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: deviceSize.width * 0.2,
                      left: deviceSize.width * 0.5,
                      top: deviceSize.height * 0.35,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSignIn ? Colors.white : Colors.green,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (isSignIn == true) {
                              setState(() {
                                passwordController.text = '';
                                emailController.text = '';
                                isSignIn = false;
                              });
                            }
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: isSignIn ? Colors.green : Colors.white,
                              fontSize: deviceSize.width * 0.036,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceSize.height * 0.03),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  height: deviceSize.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        title: TextFormField(
                          controller: emailController,
                          cursorColor: Colors.green,
                          decoration: const InputDecoration(
                            hintText: 'email',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        title: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.green,
                          obscureText: showPassword,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.03),
                TextButton(
                  onPressed: () {
                    isSignIn ? signUserIn() : signUserUp();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(
                      deviceSize.width * 0.8,
                      deviceSize.height * 0.06,
                    ),
                  ),
                  child: Text(
                    isSignIn ? 'Sign in' : 'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.05),
                Text(
                  isSignIn ? 'Or Sign in with' : 'Or Sign up with',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: deviceSize.width * 0.04,
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.01),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.green,
                    ),
                    Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.green,
                    ),
                    Icon(
                      FontAwesomeIcons.google,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: deviceSize.height * 0.01),
                Divider(
                  endIndent: deviceSize.width * 0.05,
                  indent: deviceSize.width * 0.05,
                ),
                SizedBox(height: deviceSize.height * 0.04),
                Visibility(
                  visible: isSignIn,
                  child: TextButton(
                    onPressed: () {
                      // forgotPassword();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswrodPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: deviceSize.width * 0.04,
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
