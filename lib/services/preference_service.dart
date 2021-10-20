import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerPreferenceService = Provider<PreferenceService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return PreferenceService(uid: auth?.uid);
  }
  return null;
});

final providerPreference = StreamProvider<Preference>((ref) {
  final db = ref.watch(providerPreferenceService);

  return db.streamPreference();
});

abstract class _BasePreferenceService {}

class PreferenceService {
  PreferenceService({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirebaseFirestore.instance;

  Future<void> createPreference(Preference preference) {
    Logger().i('create preference');
    return _service.collection(Path.preferences()).doc(uid).set(preference.toMap());
  }

  Future<void> updatePreference({@required dynamic name, @required dynamic value}) {
    Logger().i('update preference');
    return _service.collection(Path.preferences()).doc(uid).update({name: value});
  }

  Stream<Preference> streamPreference() {
    Logger().i('stream preference');
    return _service.collection(Path.preferences()).doc(uid).snapshots().map(
          (snapshot) => Preference.fromMap(snapshot.data(), snapshot.id),
        );
  }
}
