import 'package:app_web/controllers/category_controller.dart';
import 'package:app_web/models/category.dart';
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
    return FutureBuilder(
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
                shrinkWrap: true,
                itemCount: categorys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final category = categorys[index];
                  return Column(
                    children: [
                      Image.network(category.image, height: 100, width: 100),
                      Text(category.name),
                    ],
                  );
                });
          }
        });
  }
}
