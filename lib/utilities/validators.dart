import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';

abstract class Validators {
  static bool isAccess(AccessLevel access, String myUid, Account account, List<Favorite> followers) {
    if (myUid == account.uid) return true;
    if (access == AccessLevel.private) return false;
    if (access == AccessLevel.friends) {
      for (Favorite element in followers) {
        if (element.uid == account.uid) return true;
      }

      return false;
    }
    if (access == AccessLevel.coach && account.coach != myUid) return false;

    return true;
  }
}
