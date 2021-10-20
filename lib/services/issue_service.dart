import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerIssueService = Provider<IssueService>((ref) {
  final auth = ref.watch(providerAuthState);

  if (auth.data?.value?.uid != null) {
    return IssueService(uid: auth.data?.value?.uid);
  }
  return null;
});

abstract class _BaseIssuesService {}

class IssueService {
  IssueService({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirebaseFirestore.instance;

  Future<void> createIssue(Issue issuesReport) {
    Logger().i('create issue');
    String _path;
    if (issuesReport.elementType == ETypeElement.product) _path = Path.products();
    if (issuesReport.elementType == ETypeElement.recipe) _path = Path.recipes();

    final DocumentReference ref = _service.collection(_path).doc(issuesReport.id).collection(Path.issues()).doc(uid);
    return ref.set(issuesReport.toMap(uid));
  }

  Future<bool> alreadyIssue(String id, ETypeElement elementType) {
    Logger().i('already issue');
    String _path;
    if (elementType == ETypeElement.product) _path = Path.products();
    if (elementType == ETypeElement.recipe) _path = Path.recipes();
    return _service.collection(_path).doc(id).collection(Path.issues()).doc(uid).get().then(
          (value) => value.data() != null ? true : false,
        );
  }
}
