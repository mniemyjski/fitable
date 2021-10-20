import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerMeasurementService = Provider<MeasurementService>((ref) {
  final auth = ref.watch(providerAuthState).data.value;

  if (auth?.uid != null) {
    return MeasurementService(uid: auth?.uid);
  }
  return null;
});

final providerMeasurement = StreamProvider<List<Measurement>>((ref) {
  final db = ref.watch(providerMeasurementService);

  return db.streamMeasurement();
});

abstract class _BaseMeasurementService {}

class MeasurementService {
  MeasurementService({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirebaseFirestore.instance;

  Future<void> setMeasurement({@required Measurement measurement}) {
    Logger().i('update measurement');
    final DocumentReference ref = _service.collection(Path.accounts()).doc(uid).collection(Path.measurements()).doc(measurement.id ?? null);
    return ref.set(measurement.toMap(ref.id, uid));
  }

  Future<void> deleteMeasurement(Measurement measurement) {
    Logger().i('delete measurement');
    return _service.collection(Path.accounts()).doc(uid).collection(Path.measurements()).doc(measurement.id).delete();
  }

  Stream<List<Measurement>> streamMeasurement() {
    Logger().i('stream measurement');
    return _service
        .collection(Path.accounts())
        .doc(uid)
        .collection(Path.measurements())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Measurement.fromMap(snap.data(), snap.id)).toList());
  }
}
