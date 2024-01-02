import 'package:flutter/material.dart';
import 'package:restapi/model/post.dart'; // Assurez-vous d'importer le modèle Restaurant

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            restaurant.name,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(restaurant.logo ?? ''),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Text(
            //     restaurant.name,
            //     style: TextStyle(
            //         fontSize: 24,
            //         color: Theme.of(context).primaryColor,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '\$${restaurant.discountValue}',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'About this product:',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                restaurant.description,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            )
          ],
        ),
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text(restaurant.name),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.network(restaurant.logo ?? ''),
    //         Text(
    //           restaurant.name,
    //           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         // Ajoutez d'autres détails ici si nécessaire
    //       ],
    //     ),
    //   ),
    // );
  }
}
