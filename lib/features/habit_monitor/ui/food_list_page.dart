import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  final String imgUrl;
  final String productName;
  final String qnt;
  final bool isFav;

  final int cartQnt;
  const FoodListPage({
    super.key,
    required this.imgUrl,
    required this.productName,
    required this.qnt,
    required this.isFav,
    required this.cartQnt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(imgUrl), fit: BoxFit.cover)),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(productName), Text(qnt)],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(CupertinoIcons.heart),
              Row(
                children: [
                  const Icon(CupertinoIcons.minus_circle),
                  const SizedBox(width: 6),
                  Text(cartQnt.toString()),
                  const SizedBox(width: 6),
                  const Icon(CupertinoIcons.add_circled),
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.cart))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
