import 'package:fitable/models/account_model.dart';
import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/utilities/enums.dart';

abstract class Validators {
  static bool isAccess(ETypeAccess access, String myUid, Account account, List<Favorite> followers) {
    if (myUid == account.uid) return true;
    if (access == ETypeAccess.private) return false;
    if (access == ETypeAccess.friends) {
      for (Favorite element in followers) {
        if (element.uid == account.uid) return true;
      }

      return false;
    }
    if (access == ETypeAccess.coach && account.coach != myUid) return false;

    return true;
  }
}
