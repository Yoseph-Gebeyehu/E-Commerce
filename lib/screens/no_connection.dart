import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: deviceSize.height * 0.5,
            child: Lottie.asset(
              'assets/no_internet.json',
            ),
          ),
          Text(
            'Oops!',
            style: TextStyle(
              fontSize: deviceSize.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: deviceSize.width * 0.045,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          Text(
            'Something went wrong. Please  check your internet connection and try again.',
            style: TextStyle(fontSize: deviceSize.width * 0.036),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: deviceSize.height * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                deviceSize.width * 0.8,
                deviceSize.height * 0.055,
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: Color(0xFFA0C2C3),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: deviceSize.width * 0.036),
            ),
          ),
        ],
      ),
    );
  }
}
