import 'package:customer_store_app/controllers/category_controller.dart';
import 'package:customer_store_app/controllers/sub_category_controller.dart';
import 'package:customer_store_app/models/category.dart';
import 'package:customer_store_app/models/sub_category_model.dart';
import 'package:customer_store_app/views/screens/inner/screen/widget/sub_category_tile_widget.dart';
import 'package:customer_store_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategory;
  Category? _selectedCategory;
  List<SubCategory> _subCategory = [];

  final SubCategoryController _subCategoryController = SubCategoryController();

  @override
  void initState() {
    super.initState();
    futureCategory = CategoryController().loadCategory();
    //once category  are loaded successfully
    futureCategory.then((value) {
      //iterate through the categgory to find the Shoes(category)
      for (var category in value) {
        if (category.name == "Shoes") {
          setState(() {
            _selectedCategory = category;
          });
          //load subcategories for shoes
          _loadSubCategory(category.name);
        }
      }
    });
  }

//load sub category based on category name
  Future<void> _loadSubCategory(String categoryName) async {
    final subCategory =
        await _subCategoryController.getSubCategoryByCategoryName(categoryName);
    setState(() {
      _subCategory = subCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: const HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side
          Expanded(
//how much space we want it to take
            flex: 2,
            child: Container(
              color: const Color.fromARGB(60, 53, 52, 52),
              child: FutureBuilder(
                future: futureCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error ${snapshot.error}'));
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubCategory(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == category
                                  ? const Color.fromARGB(255, 1, 42, 75)
                                  : const Color.fromARGB(255, 127, 183, 230),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          //Right side
          Expanded(
            flex: 5,
            child: _selectedCategory != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(_selectedCategory!.banner),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        _subCategory.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _subCategory.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 4,
                                        childAspectRatio: 2 / 3),
                                itemBuilder: (context, index) {
                                  final subCategorys = _subCategory[index];
                                  return SubCategoryTileWidget(
                                      image: subCategorys.image,
                                      title: subCategorys.subCategoryName);
                                })
                            : const Center(
                                child: Text("No Sub Category"),
                              )
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
