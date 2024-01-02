import 'package:flutter/material.dart';
import 'package:restapi/model/post.dart';
import 'package:restapi/services/fetchapp.dart';
import 'package:restapi/view/restauDetail.dart';
import 'package:restapi/welcomeScreen.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/RestaurantListPage';
  final List<Restaurant> restaurantData;

  const RestaurantListPage({
    Key? key,
    required this.restaurantData,
  }) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Restaurant List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xffFC4401),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xffFC4401),
                    title: const Text("Confirmation"),
                    content: const Text(
                        "Êtes-vous sûr de vouloir vous déconnecter ?"),
                    actions: [
                      TextButton(
                        child: const Text("Annuler"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Déconnexion"),
                        onPressed: () {
                          logOut(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.restaurantData.length,
        itemBuilder: (context, index) {
          return Card(
              color: const Color.fromARGB(255, 254, 248, 246),
              elevation: 10,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20)),
                  // Ajustez le rayon ici également
                  child: Image.network(
                    widget.restaurantData[index].logo ?? '',
                    fit: BoxFit.cover,
                    width: 60, // Ajustez la largeur selon votre besoin
                    height: 150, // Ajustez la hauteur selon votre besoin
                  ),
                ),
                title: Text(
                  widget.restaurantData[index].name.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(
                          restaurant: widget.restaurantData[index],
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ));
          // return Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Image.network(restaurantData[index].logo ?? ''),
          //     ),
          //     Text(restaurantData[index].name.toString()),
          //   ],

          //   // Ajoutez d'autres détails ici si nécessaire
          // );
        },
      ),
    );
  }
}
