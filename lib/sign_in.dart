import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showPassword = true;
  bool isSignIn = true;

  snackBar(String title) {
    Size deviceSize = MediaQuery.of(context).size;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: deviceSize.width * 0.036),
        ),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }

  void signUserUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: passwordController.text,
        password: passwordController.text,
      );
    } catch (error) {
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'weak-password':
            snackBar('Password should be at least 6 characters');
            break;
          case 'invalid-email':
            snackBar('The email address is not correct');
            break;
          case 'email-already-in-use':
            snackBar('The email address is already in use by another account');
            break;
          default:
            snackBar('An unexpected error occurred. Please try again later.');
          // print('Firebase Auth error: ${error.code}');
        }
        // print('error ${error.toString()}');
      } else {
        snackBar('An unexpected error occurred. Please try again later.');
        // print('Unexpected error: $error');
      }
    }
  }

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userNameController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        snackBar('The password is wrong');
      } else if (e.code == 'invalid-email') {
        snackBar('The email is invalid');
      } else if (e.code == 'invalid-credential') {
        snackBar('The email or password is wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        setState(() {
                          userNameController.text = '';
                          passwordController.text = '';
                          isSignIn = true;
                        });
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
                        setState(() {
                          userNameController.text = '';
                          passwordController.text = '';
                          emailController.text = '';
                          isSignIn = false;
                        });
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
              margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              height: isSignIn
                  ? deviceSize.height * 0.17
                  : deviceSize.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    title: TextFormField(
                      controller: userNameController,
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        hintText: 'User Name',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const Divider(),
                  Visibility(
                    visible: !isSignIn,
                    child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      title: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.green,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isSignIn,
                    child: const Divider(),
                  ),
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
                        showPassword ? Icons.visibility_off : Icons.visibility,
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
                // signUserIn();
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
                onPressed: () {},
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
        ),
      ),
    );
  }
}
