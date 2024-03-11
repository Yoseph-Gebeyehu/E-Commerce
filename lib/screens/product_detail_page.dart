import 'package:e_commerce/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  Product product;
  ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  PageController pageController = PageController();
  int currentShowIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: deviceSize.height * 0.3,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: widget.product.images.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentShowIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.product.images[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,

                    right: deviceSize.width * 0.35,
                    left: deviceSize.width * 0.35,
                    // top: deviceSize.height * 0.35,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black54,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedSmoothIndicator(
                          activeIndex: currentShowIndex,
                          count: widget.product.images.length,
                          curve: Curves.easeOutSine,
                          effect: CustomizableEffect(
                            dotDecoration: DotDecoration(
                              height: 11,
                              width: 8,
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                            activeDotDecoration: const DotDecoration(
                              height: 10,
                              width: 10,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${widget.product.price.toString()} Br",
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    // "${widget.product.price.toString()} Br",
                    widget.product.brand,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.product.discountPercentage.toStringAsFixed(2)}% OFF',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width * 0.04,
                ),
              ),
              Text(widget.product.description),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: widget.product.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Colors.black12,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const Spacer(),
                    Text(
                      widget.product.rating.toString(),
                      style: TextStyle(fontSize: deviceSize.width * 0.036),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Container(
                  height: deviceSize.height * 0.05,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
