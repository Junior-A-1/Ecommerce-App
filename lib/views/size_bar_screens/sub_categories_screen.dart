import 'package:app_web/controllers/category_controller.dart';
import 'package:app_web/controllers/sub_category_controller.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/views/size_bar_screens/widgets/sub_category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const String id = '\subCategoriesScreen';
  const SubCategoriesScreen({super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final SubCategoryController subCategoryController = SubCategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;
  late String subCategoryName;
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

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
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
                    'Sub Categories',
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
              FutureBuilder(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('nO CATEGORY '),
                      );
                    } else {
                      return DropdownButton<Category>(
                          value: selectedCategory,
                          hint: const Text('Select Category'),
                          items: snapshot.data!.map((Category category) {
                            return DropdownMenuItem(
                                value: category, child: Text(category.name));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                            print(selectedCategory!.name);
                          });
                    }
                  }),
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
                              child: Text('Sub Category image'),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) {
                          subCategoryName = value;
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter sub category name';
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: 'Enter Sub Category Name'),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'cancel',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await subCategoryController.uploadSubCategory(
                            categoryId: selectedCategory!.id,
                            categoryName: selectedCategory!.name,
                            pickedImage: _image,
                            subCategoryName: subCategoryName,
                            context: context);
                      }

                      setState(() {
                        _formKey.currentState!.reset();
                        _image = null;
                      });
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
                    'Pick Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SubCategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
