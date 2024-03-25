import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cdm/features/habit_monitor/models/product_model.dart';
import 'package:project_cdm/features/habit_monitor/repository/firebase/custom_product_update.dart';
import 'package:project_cdm/features/habit_monitor/ui/food_list_page.dart';
import 'package:project_cdm/features/habit_monitor/ui/new_product_page.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  int currCategory = 0;
  final _collections = ['All', 'Favorite', 'Junk', 'custom'];
  List<ProductModel> _productList = [];
  List<ProductModel>? dynamicList;

  Future<List<Map<String, dynamic>>>? initFetch;

  Future<List> getCustomProduct() async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc('LEjG7hXqcDfK1eOjgqgL3gJ2ZX12');
    Map<String, dynamic>? data;
    await doc.get().then((snap) {
      data = snap.data();
    });
    return data!['customProducts'];
  }

  @override
  void initState() {
    initFetch = CustomProductService.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamicList ??= _productList;
    final data = _productList.where((item) => item.isFav == true).toList();
    final junkList =
        _productList.where((item) => item.category == 'Junk').toList();
    List<Map<String, dynamic>> customProducts = [];
    return Scaffold(
        floatingActionButton: currCategory == 3
            ? MaterialButton(
                shape: const CircleBorder(),
                color: Colors.blue,
                padding: const EdgeInsets.all(15),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewProductPage()));
                },
                child: const Icon(Icons.add),
              )
            : null,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                floating: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Food List',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              labelText: 'Search',
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _collections.length,
                            itemBuilder: (context, index) {
                              Color? colors = Colors.grey[200];
                              if (currCategory == index) {
                                colors = Colors.orangeAccent;
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currCategory = index;
                                      if (currCategory == 0) {
                                        dynamicList = _productList;
                                      } else if (currCategory == 1) {
                                        dynamicList = data;
                                      } else if (currCategory == 2) {
                                        dynamicList = junkList;
                                      }
                                    });
                                  },
                                  child: Chip(
                                      side: BorderSide.none,
                                      backgroundColor: colors,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: Text(_collections[index])),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
              FutureBuilder(
                  future: initFetch,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      customProducts = snapshot.data!;
                      print(customProducts);
                      _productList = customProducts
                          .map((data) => ProductModel.fromMap(data))
                          .toList();
                    }

                    return SliverGrid.builder(
                        itemCount: _productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 320, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final item = _productList[index];
                          return FoodListPage(
                            imgUrl: item.imgUrl,
                            productName: item.productName,
                            qnt: item.qnt,
                            isFav: item.isFav,
                            cartQnt: item.cartQnt,
                          );
                        });
                  }),
            ],
          ),
        ));
  }
}
