import 'package:customer_store_app/controllers/category_controller.dart';
import 'package:customer_store_app/models/category.dart';
import 'package:customer_store_app/views/screens/inner/screen/inner_category_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/widgets/resusable_test_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = CategoryController().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResusableTestWidget(title: "Categories", subTitle: "View all"),
        FutureBuilder(
            future: futureCategory,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Categories'),
                );
              } else {
                final categorys = snapshot.data!;
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categorys.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      final category = categorys[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InnerCategoryScreen(
                              category: category,
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Image.network(category.image,
                                height: 47, width: 47),
                            Text(
                              category.name,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }),
      ],
    );
  }
}
