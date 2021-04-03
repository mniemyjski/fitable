import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final providerCommunityViewModel = ChangeNotifierProvider.autoDispose<CommunityViewModel>((ref) => CommunityViewModel());

class CommunityViewModel extends ChangeNotifier {}
