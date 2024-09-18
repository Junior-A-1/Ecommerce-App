import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker picker = ImagePicker();
  List<File> images = [];

  chooseImageFromGallery() async {
    final pickImageFromGallary =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickImageFromGallary == null) {
      print("No image picked");
    } else {
      setState(() {
        images.add(File(pickImageFromGallary.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: images.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                        onPressed: () {
                          chooseImageFromGallery();
                        },
                        icon: const Icon(Icons.add)),
                  )
                : SizedBox(
                    height: 40,
                    width: 50,
                    child: Image.file(
                      images[index - 1],
                    ),
                  );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Name',
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: 'enter product name',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Price',
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: '\$',
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Quantity',
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: 'enter product quantity',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  maxLines: 3,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Description',
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: 'write...',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
