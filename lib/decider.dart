import 'package:e_commerce/api/api_client.dart';
import 'package:e_commerce/models/product_list.dart';
import 'package:e_commerce/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Decider extends StatefulWidget {
  @override
  State<Decider> createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  // const AuthPage({super.key});
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  ProductList? productList;

  Future<void> getProductList() async {
    try {
      ApiClient apiClient = ApiClient();
      var apiResponse = await apiClient.getProductList();
      if (apiResponse.body != null && apiResponse.status == 200) {
        setState(() {
          productList = ProductList.fromJson(apiResponse.body);
        });
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return productList == null
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 10,
                    title: const Text('Product Lists'),
                    actions: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Log out of your account?',
                                  textAlign: TextAlign.center,
                                ),
                                content: SizedBox(
                                  height: deviceSize.height * 0.17,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      const Divider(),
                                      TextButton(
                                        onPressed: () {
                                          signUserOut();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Decider(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontSize: deviceSize.width * 0.05,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: deviceSize.width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                              );
                            },
                          );
                        },
                        child: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                  body: Center(
                    child: ListView.builder(
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              productList!.products[i].thumbnail,
                            ),
                          ),
                          title: Text(
                            productList!.products[i].title.toString(),
                          ),
                          subtitle: Text(productList!.products[i].description),
                          trailing: Text(productList!.products[i].brand),
                        );
                      },
                      itemCount: productList!.products.length,
                    ),
                  ),
                );
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
