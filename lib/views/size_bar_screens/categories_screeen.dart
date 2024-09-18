import 'package:app_web/controllers/category_controller.dart';
import 'package:app_web/views/size_bar_screens/widgets/category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = '\categories-screen';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoryController _categoryController = CategoryController();
  late String categoryName;
  dynamic _bannerImage;
  dynamic _image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      print("File picked: ${result.files.first.name}");
      setState(() {
        _image = result.files.first.bytes;
      });
    } else {
      print("No file picked.");
    }
  }

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      print("Banner file picked: ${result.files.first.name}");
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    } else {
      print("No banner file picked.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: _image != null
                        ? Image.memory(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Text('Category image'),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter category name';
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Enter Category Name'),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'cancel',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _categoryController.uploadCategory(
                          pickedImage: _image,
                          pickedBanner: _bannerImage,
                          name: categoryName,
                          context: context);
                    }
                  },
                  child: const Text(
                    'save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  pickImage();
                },
                child: const Text(
                  'Upload picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: _bannerImage != null
                      ? Image.memory(
                          _bannerImage!,
                        )
                      : const Text(
                          'Category banner',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  pickBannerImage();
                },
                child: const Text(
                  'Pick Banner Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
