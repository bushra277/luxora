import 'package:flutter/material.dart';
import 'package:task_flutter/core/utils/responsive.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/features/product/models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Detailes'),
      body: Padding(
        padding: EdgeInsets.all(context.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(product.images?.first , context),
            SizedBox(height: context.h(40)),
            Text(
              product.title!,
              style: TextStyle(
                  fontSize: context.sp(40), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.h(24)),
            Text(
              "\$${product.price}",
              style: TextStyle(fontSize: context.sp(40), color: Colors.green , fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.h(28)),
            Text(
              product.description!,
              style: TextStyle(fontSize: context.sp(32)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(String? url , BuildContext context) {
  if (url == null || url.isEmpty || !url.startsWith('http')) {
    return Container(
      width: context.w(100), 
      height: context.h(100),
      color: Colors.grey[300],
      child: Icon(Icons.broken_image, size: context.sp(30), color: Colors.grey[700]),
    );
  }

  return Image.network(
    url,
    width: MediaQuery.sizeOf(context).width,
    height: context.h(1100),
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        height: context.h(900),
        color: Colors.grey[300],
        child: Icon(Icons.broken_image, size: context.sp(30), color: Colors.grey[700]),
      );
    },
  );
}
}
