// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../app/account/repositories/account_repository.dart' as _i7;
import '../../app/account/repositories/avatar_repository.dart' as _i6;
import '../../app/auth/repositories/auth_repository.dart' as _i5;
import '../../utilities/services/api.dart' as _i3;
import '../../utilities/services/app_write.dart' as _i4;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.Api>(_i3.Api());
  gh.singleton<_i4.AppWrite>(_i4.AppWriteDev(), registerFor: {_dev});
  gh.singleton<_i4.AppWrite>(_i4.AppWriteProduction(), registerFor: {_prod});
  gh.singleton<_i5.AuthRepository>(_i5.AuthRepository(get<_i4.AppWrite>()));
  gh.singleton<_i6.AvatarRepository>(_i6.AvatarRepository(get<_i4.AppWrite>()));
  gh.singleton<_i7.AccountRepository>(
      _i7.AccountRepository(get<_i4.AppWrite>()));
  return get;
}
