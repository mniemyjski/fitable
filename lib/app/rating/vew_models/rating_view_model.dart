import 'package:fitable/app/rating/models/rating_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRatingViewModel = ChangeNotifierProvider.autoDispose<RatingViewModel>((ref) {
  return RatingViewModel();
});

class RatingViewModel extends ChangeNotifier {
  setRating(BuildContext context, String id, double value) {
    Rating rating = Rating(id: id, rating: value);

    context.read(providerDatabase).updateRating(context, rating);
    notifyListeners();
  }
}