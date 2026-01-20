import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/utils/responsive.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/core/widgets/custom_elevated_button.dart';
import 'package:task_flutter/core/widgets/custom_text_field.dart';
import 'package:task_flutter/features/category/cuibt/category_cubit.dart';
import 'package:task_flutter/features/category/cuibt/category_state.dart';
import 'package:task_flutter/features/category/models/category_model.dart';
import 'package:task_flutter/features/product/cubit/product_cubit.dart';
import 'package:task_flutter/features/product/models/product_model.dart';

class ProductAddEditPage extends StatefulWidget {
  final ProductModel? product;
  const ProductAddEditPage({super.key, this.product});

  @override
  State<ProductAddEditPage> createState() => _ProductAddEditPageState();
}

class _ProductAddEditPageState extends State<ProductAddEditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descController;
  late TextEditingController imageController;

  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product?.title ?? '');
    priceController =
        TextEditingController(text: widget.product?.price?.toString() ?? '');
    descController =
        TextEditingController(text: widget.product?.description ?? '');
    imageController = TextEditingController(
        text: widget.product?.images?.first ?? 'https://placehold.co/600x400');
    context.read<CategoryCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.w(16);

    return Scaffold(
      appBar: CustomAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.w(40)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Title' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
            SizedBox(height: context.h(16),),
            CustomTextField(
              hint: "Title",
              controller: titleController,
              validator: (v) => v == null || v.isEmpty ? "Required" : null,
            ),
          SizedBox(height: context.h(38)),
    Text('Price' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
            SizedBox(height: context.h(16),),
    CustomTextField(
      hint: "Price",
      controller: priceController,
      keyboardType: TextInputType.number,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    ),
    SizedBox(height: context.h(38)),
    Text('Description' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
            SizedBox(height: context.h(16),),
    CustomTextField(
      hint: "Description",
      controller: descController,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    ),
    SizedBox(height: context.h(38)),
    Text('Category' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
            SizedBox(height: context.h(16),),
    BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CircularProgressIndicator();
        } else if (state is CategoryLoaded) {
          if (selectedCategory == null && widget.product?.category != null) {
            selectedCategory = state.categories.firstWhere(
              (c) => c.id == widget.product!.category!.id,
              orElse: () => state.categories.first,
            );
          }

          return DropdownButtonFormField<CategoryModel>(
            value: selectedCategory ?? state.categories.first,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.w(15)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.w(30),
                vertical: context.h(20),
              ),
            ),
            items: state.categories
                .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(
                        c.name ?? 'No name',
                        style: TextStyle(fontSize: context.sp(30)),
                      ),
                    ))
                .toList(),
            onChanged: (c) {
              setState(() {
                selectedCategory = c;
              });
            },
            validator: (v) => v == null ? "Required" : null,
          );
        } else if (state is CategoryError) {
          return Text("Error: ${state.message}");
        } else {
          return const SizedBox();
        }
      },
    ),
    SizedBox(height: context.h(38)),
    Text('Image' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
            SizedBox(height: context.h(16),),
    CustomTextField(
      hint: "Image URL",
      controller: imageController,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    ),
              SizedBox(height: context.h(60)),
              CustomElevatedButton(
                text: 'Add  or Edit Product', 
                onPressed: (){
                  if (!_formKey.currentState!.validate()) return;

                    final product = ProductModel(
                      title: titleController.text,
                      price: int.parse(priceController.text),
                      description: descController.text,
                      category: selectedCategory,
                      images: [imageController.text],
                    );

                    if (widget.product == null) {
                      context.read<ProductCubit>().addProduct(product);
                    } else {
                      context.read<ProductCubit>().updateProduct(
                            widget.product!.id!,
                            product,
                          );
                    }

                    Navigator.pop(context);
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

