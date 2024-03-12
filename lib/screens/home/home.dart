import 'package:e_commerce/screens/product-detail/product_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../decider.dart';
import '../../models/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getProductList();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
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

  List<Product> filterCategory(String category) {
    return productList!.products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    if (productList == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return DefaultTabController(
        length: 7,
        child: Scaffold(
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
                child: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.logout),
                ),
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Text('All'),
                Text('Smartphones'),
                Text('Laptops'),
                Text('Fragrances'),
                Text('Skincare'),
                Text('Groceries'),
                Text('Home Decoration'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              gridView(deviceSize, productList!.products),
              gridView(deviceSize, filterCategory('smartphones')),
              gridView(deviceSize, filterCategory('laptops')),
              gridView(deviceSize, filterCategory('fragrances')),
              gridView(deviceSize, filterCategory('skincare')),
              gridView(deviceSize, filterCategory('groceries')),
              gridView(deviceSize, filterCategory('home-decoration')),
            ],
          ),
        ),
      );
    }
  }

  Center gridView(Size deviceSize, List<Product> products) {
    return Center(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: deviceSize.width * 0.0375,
          crossAxisSpacing: deviceSize.width * 0.0375,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GridTile(
              footer: Container(
                color: Colors.black.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${products[i].price} br",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceSize.width * 0.036,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        products[i].category,
                        style: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      product: products[i],
                    ),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    products[i].thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
