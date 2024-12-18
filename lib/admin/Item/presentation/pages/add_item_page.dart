import 'dart:io';

import 'package:coffee_app/app.dart';
import 'package:coffee_app/common/loading_button.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_cubit.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  String imagePath = '';

  void pickImage() async {
    // pick an image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    // crop image
    final ImageCropper imageCropper = ImageCropper();
    final CroppedFile? cropped = await imageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (cropped == null) return;

    setState(() {
      imagePath = cropped.path;
    });
  }

  Future<void> addItem() async {
    // field is empty
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descController.text.isEmpty ||
        imagePath.isEmpty) {
      context.showSnackBar('Please provide all the data needed');
      return;
    }

    // price is not number
    double price = 0;
    try {
      price = double.parse(priceController.text);
    } catch (e) {
      context.showSnackBar('Invalid price');
    }

    // add item
    await context.read<ItemCubit>().addItem(
          nameController.text,
          descController.text,
          price,
          imagePath,
        );

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(
          children: [
            // item image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // upload button
                IconButton.filled(
                  onPressed: pickImage,
                  icon: const Icon(Icons.cloud_upload),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // item name
            const Text('Item Name'),
            TextField(
              controller: nameController,
            ),

            const SizedBox(height: 10),

            // item price
            const Text('Price'),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            // item description
            const Text('Description'),
            TextField(
              controller: descController,
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            LoadingButton(
              text: 'Add Item',
              callback: addItem,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
