import 'package:cloud_firestore/cloud_firestore.dart';

///Collection must have the same name as Favorite!!!
enum EnumFavorite { products, recipes, exercise, trainings, users }

class Favorite {
  final String uid;
  final String type;
  final String category;
  final String id;

  Favorite({this.uid, this.type, this.category, this.id});

//   factory Favorite.fromFirestore(DocumentSnapshot document) {
//     Map data = document.data;
//
//     return Favorite(
//       uid: data['uid'],
//       type: data['type'],
//       category: data['category'],
//       id: data['id'],
//     );
//   }
// }
//
// favoritesName(EnumFavorite favorite) {
//   switch (favorite) {
//     case EnumFavorite.products:
//       return 'products';
//     case EnumFavorite.recipes:
//       return 'recipes';
//     case EnumFavorite.exercise:
//       return 'exercise';
//     case EnumFavorite.trainings:
//       return 'trainings';
//     case EnumFavorite.users:
//       return 'users';
//   }
}
