import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/localization/app_localizations.dart';
import 'package:task_flutter/core/localization/language_cubit.dart';
import 'package:task_flutter/core/utils/responsive.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/features/product/cubit/product_cubit.dart';
import 'package:task_flutter/features/product/cubit/product_state.dart';
import 'package:task_flutter/features/product/pages/product_detail_page.dart';
import 'package:task_flutter/features/product/pages/product_form_page.dart';
import 'package:task_flutter/features/profile/pages/profile_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: context.sp(80)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductAddEditPage(),
                ),
              ).then(
                (_) => context.read<ProductCubit>().fetchProducts(),
              );
            },
          ),
          IconButton(
  icon: const Icon(Icons.language),
  onPressed: () {
    final cubit = context.read<LanguageCubit>();

    if (cubit.state.languageCode == 'en') {
      cubit.changeLanguage(const Locale('ar'));
    } else {
      cubit.changeLanguage(const Locale('en'));
    }
  },
),

        ],
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
        }, icon: Icon(Icons.person)),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: context.h(30),),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: context.h(150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.w(30)),
                      color: const Color.fromARGB(255, 255, 254, 254),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 85, 84, 84).withOpacity(0.1), 
                          spreadRadius: 1, 
                          blurRadius: 10, 
                          offset: const Offset(0, 5), 
                        ),
                      ],
                       
                    ),
                    child: Center(child: Text(AppLocalizations.of(context).translate("Shop Now"),style: TextStyle(color: const Color.fromARGB(255, 96, 94, 94) , fontSize: context.sp(50) , fontWeight: FontWeight.bold),))),
                  SizedBox(height: context.h(30),),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(context.w(40)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: context.w(26),
                        mainAxisSpacing: context.h(32),
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product),));
                          },
                          child: Card(
                            margin: EdgeInsets.zero, 
                            child: Padding(
                              padding: EdgeInsets.all(context.w(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildProductImage(product.images?.first, context),
                                  SizedBox(height: context.h(16)),
                                  Text(
                                    product.title!,
                                    style: TextStyle(
                                      fontSize: context.sp(28),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: context.h(10)),
                                  Text(
                                    "\$${product.price}",
                                    style: TextStyle(
                                      fontSize: context.sp(30),
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blueAccent),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductAddEditPage(product: product),
                                            ),
                                          ).then(
                                            (_) =>
                                                context.read<ProductCubit>().fetchProducts(),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text("Delete Product"),
                                              content: Text(
                                                  "Are you sure you want to delete this product?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<ProductCubit>()
                                                        .deleteProduct(product.id!);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Delete"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildProductImage(String? url, BuildContext context) {
    if (url == null || url.isEmpty || !url.startsWith('http')) {
      return Container(
        width: context.w(200),
        height: context.h(200),
        color: Colors.grey[300],
        child: Icon(
          Icons.broken_image,
          size: context.sp(30),
          color: Colors.grey[700],
        ),
      );
    }

    return Image.network(
      url,
      width: MediaQuery.sizeOf(context).width,
      height: context.h(360),
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: context.w(100),
          height: context.h(100),
          color: Colors.grey[300],
          child: Icon(
            Icons.broken_image,
            size: context.sp(30),
            color: Colors.grey[700],
          ),
        );
      },
    );
  }
}
