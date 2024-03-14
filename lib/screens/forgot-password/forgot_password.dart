import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign-in/bloc/auth_bloc.dart';

class ForgotPasswrodPage extends StatefulWidget {
  const ForgotPasswrodPage({super.key});

  @override
  State<ForgotPasswrodPage> createState() => _ForgotPasswrodPageState();
}

class _ForgotPasswrodPageState extends State<ForgotPasswrodPage> {
  TextEditingController forgotEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: const Color(0xFFA0C2C3),
      appBar: AppBar(
        // backgroundColor: const Color(0xFFA0C2C3),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.048,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height * 0.01),
              Text(
                'Enter your registered email below to recieve password reset instruction',
                style: TextStyle(
                  fontSize: deviceSize.width * 0.04,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                'assets/forgot_password.webp',
                fit: BoxFit.contain,
              ),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width * 0.04,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.01),
              Container(
                height: deviceSize.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    cursorColor: Colors.green,
                    controller: forgotEmailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter email address',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height * 0.04),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(
                        ForgotPasswordEvent(email: forgotEmailController.text),
                      );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    deviceSize.width * 1,
                    deviceSize.height * 0.07,
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Color(0xFFA0C2C3),
                    ),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.04,
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remember Password?',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
