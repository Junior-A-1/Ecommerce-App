import 'package:customer_store_app/controllers/sub_category_controller.dart';
import 'package:customer_store_app/models/category.dart';
import 'package:customer_store_app/models/sub_category_model.dart';
import 'package:customer_store_app/views/screens/inner/screen/widget/inner_banner_widget.dart';
import 'package:customer_store_app/views/screens/inner/screen/widget/inner_header_widget.dart';
import 'package:customer_store_app/views/screens/inner/screen/widget/sub_category_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> _subCategory;
  final SubCategoryController _subCategoryController = SubCategoryController();
  @override
  void initState() {
    super.initState();
    _subCategory = _subCategoryController
        .getSubCategoryByCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: const InnerHeaderWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                'Shop By Sub Categories ',
                style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7),
              ),
            ),
            FutureBuilder(
                future: _subCategory,
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
                    final subCategorys = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                            (subCategorys.length / 7).ceil(), (setIndex) {
                          //for each row , calculate the starting and ending indices
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          //create a padding widget to add space around the row
                          return Padding(
                            padding: const EdgeInsets.all(8.9),
                            child: Row(
                              //create a row of the subcategory tie
                              children: subCategorys
                                  .sublist(
                                      start,
                                      end > subCategorys.length
                                          ? subCategorys.length
                                          : end)
                                  .map((e) => SubCategoryTileWidget(
                                      image: e.image, title: e.subCategoryName))
                                  .toList(),
                            ),
                          );
                        }),
                      ),
                      // GridView.builder(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: subCategorys.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 4,
                      //             crossAxisSpacing: 8,
                      //             mainAxisSpacing: 8),
                      //     itemBuilder: (context, index) {
                      //       final subCategory = subCategorys[index];
                      //       return SubCategoryTileWidget(
                      //           image: subCategory.image,
                      //           title: subCategory.subCategoryName);
                      //     }
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
