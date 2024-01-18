import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/model/post.dart';
import 'package:restapi/welcomeScreen.dart';

Future<bool> loginUser(LoginData loginData) async {
  const String apiUrl =
      'https://marketplace.jibaleysolution.com/api/v1/auth/login';

  // Convertir les données de l'objet LoginData en Map
  Map<String, String> loginPayload = {
    'email': loginData.email,
    'password': loginData.password,
  };

  try {
    // Convertir les données en format JSON
    String jsonData = json.encode(loginPayload);

    // Envoyer la requête POST avec les en-têtes appropriés
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonData,
    );

    // Vérifier la réponse
    if (response.statusCode == 200) {
      // Si la connexion réussit
      print('Connexion réussie! Voici la réponse : ${response.body}');
      // TODO: Gérer la réponse, peut-être stocker le token d'authentification

      return true; // Renvoyer true pour indiquer la réussite de la connexion
    } else {
      // Si la connexion échoue
      print('Échec de la connexion. Statut code: ${response.statusCode}');
      // TODO: Gérer l'échec de la connexion, peut-être afficher un message d'erreur

      return false; // Renvoyer false pour indiquer l'échec de la connexion
    }
  } catch (e) {
    // En cas d'erreur lors de la requête
    print('Erreur lors de la requête : $e');
    // TODO: Gérer les erreurs, afficher un message d'erreur par exemple

    return false; // Renvoyer false en cas d'erreur
  }
}

Future<bool> SignUser(SignData signData) async {
  const String apiUrl =
      'https://marketplace.jibaleysolution.com/api/v1/auth/signup';

  // Convertir les données de l'objet LoginData en Map
  Map<String, String> loginPayload = {
    'name': signData.email,
    'email': signData.email,
    'password': signData.password,
    'password_confirmation': signData.password,
  };

  try {
    // Convertir les données en format JSON
    String jsonData = json.encode(loginPayload);

    // Envoyer la requête POST avec les en-têtes appropriés
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonData,
    );

    // Vérifier la réponse
    if (response.statusCode == 200) {
      // Si la connexion réussit
      print('Connexion réussie! Voici la réponse : ${response.body}');
      // TODO: Gérer la réponse, peut-être stocker le token d'authentification

      return true; // Renvoyer true pour indiquer la réussite de la connexion
    } else {
      // Si la connexion échoue
      print('Échec de la connexion. Statut code: ${response.statusCode}');
      // TODO: Gérer l'échec de la connexion, peut-être afficher un message d'erreur

      return false; // Renvoyer false pour indiquer l'échec de la connexion
    }
  } catch (e) {
    // En cas d'erreur lors de la requête
    print('Erreur lors de la requête : $e');
    // TODO: Gérer les erreurs, afficher un message d'erreur par exemple

    return false; // Renvoyer false en cas d'erreur
  }
}

Future<List<Restaurant>> fetchRestaurantData() async {
  String authToken =
      'Bearer 175|1ZRXn60pfG0ADsBv9pLiKXlkSjxOZlQfXWtnqs0Cd1009916';
  var response = await http.get(
    Uri.parse('https://marketplace.jibaleysolution.com/api/v1/restaurants'),
    headers: {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body)['data'];
    List<Restaurant> restaurants = jsonData.map((json) {
      return Restaurant.fromJson(json);
    }).toList();
    return restaurants;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> logOut(BuildContext context) async {
  // Replace 'YOUR_AUTH_KEY' with the actual authentication key/token
  String authToken =
      'Bearer 175|1ZRXn60pfG0ADsBv9pLiKXlkSjxOZlQfXWtnqs0Cd1009916';

  var url =
      Uri.parse('https://marketplace.jibaleysolution.com/api/v1/auth/logout');
  var headers = {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // Logout successful
    print('Logged out successfully');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      // Replace LoginScreen with your actual login screen
    );
    // Navigate back to login screen or perform any other necessary actions
  } else {
    // Logout failed
    print('Logout failed with status code: ${response.statusCode}');
    // Handle error here
  }
}
