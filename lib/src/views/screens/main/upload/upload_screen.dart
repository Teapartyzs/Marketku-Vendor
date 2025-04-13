import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketku_vendor/global_variables.dart';
import 'package:marketku_vendor/src/controllers/dio_controller.dart';
import 'package:marketku_vendor/src/models/category.dart';
import 'package:marketku_vendor/src/models/category_sub.dart';
import 'package:marketku_vendor/src/models/product.dart';
import 'package:marketku_vendor/src/providers/vendor_provider.dart';
import 'package:marketku_vendor/src/views/components/future_builder_setup.dart';
import 'package:marketku_vendor/src/views/components/input_form.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final formKey = GlobalKey<FormState>();
  late final Future<List<Category>> categoryData;
  late final Future<List<CategorySub>> categorySubData;
  Category? selectedCategory;
  CategorySub? selectedCategorySub;
  bool isPicked = false;
  final imagePicker = ImagePicker();

  List<File> images = [];

  pickImage() async {
    final takePicture = await imagePicker.pickImage(source: ImageSource.camera);

    if (takePicture == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to take picture")));
    } else {
      setState(() {
        images.add(File(takePicture.path));
      });
    }
  }

  late String productName;
  late int productPrice;
  late String vendorId;
  late String fullname;
  late int quantity;
  late String description;
  late String category;
  late String subCategory;
  late bool popular;
  late bool recommend;

  uploadProduct() async {
    final List<String> paths = [];
    if (images.isNotEmpty) {
      if (selectedCategory!.id.isNotEmpty && selectedCategory!.id.isNotEmpty) {
        final cloudinary = CloudinaryPublic("dhpriqf77", "r0gdemwm");
        for (var i = 0; i < images.length; i++) {
          CloudinaryResponse cloudinaryResponse = await cloudinary
              .uploadFile(CloudinaryFile.fromFile(images[i].path));

          paths.add(cloudinaryResponse.secureUrl);
        }
        final product = Product(
                id: '',
                productName: productName,
                productPrice: productPrice,
                vendorId: vendorId,
                fullname: fullname,
                quantity: quantity,
                description: description,
                category: selectedCategory!.name,
                subCategory: selectedCategory!.name,
                images: paths,
                popular: false,
                recommend: false)
            .toMap();

        await "$url/api/add-product".postData(product, (result, message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final categoryUrl = "$url/api/category";
    categoryData =
        categoryUrl.getDataList<Category>((map) => Category.fromMap(map));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: images.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1),
              itemBuilder: (content, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          onPressed: pickImage,
                          icon: Icon(CupertinoIcons.add),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.file(images[index - 1]),
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputForm(
                keyboardType: TextInputType.text,
                newValue: (value) {
                  productName = value;
                },
                label: "Product Name",
                hint: "Input your product name ",
                maxLines: 1,
                maxLength: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputForm(
                keyboardType: TextInputType.number,
                newValue: (value) {
                  productPrice = int.parse(value);
                },
                label: "Price",
                hint: "Input your product price ",
                maxLines: 1,
                maxLength: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputForm(
                keyboardType: TextInputType.number,
                newValue: (value) {
                  quantity = int.parse(value);
                },
                label: "Quantity",
                hint: "Input your product quantity",
                maxLines: 1,
                maxLength: 100,
              ),
            ),
            FutureBuilderSetup(
              getData: categoryData,
              builderSuccess: (categoryList) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Category:"),
                      DropdownButton<Category>(
                        value: selectedCategory,
                        hint: selectedCategory == null
                            ? Text("Select category")
                            : Text(selectedCategory!.name),
                        onChanged: (value) => setState(() {
                          isPicked = true;
                          selectedCategory = value;
                          categorySubData =
                              "$url/api/category/${selectedCategory!.name}/categorysub"
                                  .getDataList(
                                      (map) => CategorySub.fromMap(map));
                        }),
                        items: categoryList.map((Category data) {
                          return DropdownMenuItem(
                            value: data,
                            child: Text(data.name),
                          );
                        }).toList(),
                      ),
                    ]),
              ),
              builderFailed: (error) {
                return Text(error);
              },
            ),
            if (isPicked)
              FutureBuilderSetup(
                getData: categorySubData,
                builderSuccess: (categorySubList) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category Sub:"),
                        DropdownButton<CategorySub>(
                          value: selectedCategorySub,
                          hint: selectedCategorySub == null
                              ? Text("Select category sub")
                              : Text(selectedCategorySub!.categoryName),
                          onChanged: (value) => setState(() {
                            selectedCategorySub = value;
                          }),
                          items: categorySubList.map((CategorySub data) {
                            return DropdownMenuItem(
                              value: data,
                              child: Text(data.subCategoryName),
                            );
                          }).toList(),
                        ),
                      ]),
                ),
                builderFailed: (error) {
                  return Text(error);
                },
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InputForm(
                keyboardType: TextInputType.text,
                newValue: (value) {
                  description = value;
                },
                label: "Description",
                hint: "Input your product description",
                maxLines: 3,
                maxLength: 500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        fullname = ref.read(vendorProvider)!.fullname;
                        vendorId = ref.read(vendorProvider)!.id;
                        uploadProduct();
                      }
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: Text("Submit"),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
