import 'package:app_web/controllers/sub_category_controller.dart';
import 'package:app_web/models/sub_category.dart';
import 'package:flutter/material.dart';

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({super.key});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  late Future<List<SubCategory>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = SubCategoryController().loadSubCategory();
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
              child: Text('No Sub Categories'),
            );
          } else {
            final subCategorys = snapshot.data!;
            return GridView.builder(
                shrinkWrap: true,
                itemCount: subCategorys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final subCategory = subCategorys[index];
                  return Column(
                    children: [
                      Image.network(subCategory.image, height: 100, width: 100),
                      Text(subCategory.subCategoryName),
                    ],
                  );
                });
          }
        });
  }
}
