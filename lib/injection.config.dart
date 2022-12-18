// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:web_translator_ml/core/api/client.dart' as _i3;
import 'package:web_translator_ml/features/home/data/datasources/translate_datasource.dart'
    as _i4;
import 'package:web_translator_ml/features/home/data/repositories/home_repository_impl.dart'
    as _i6;
import 'package:web_translator_ml/features/home/domain/repositories/home_repository.dart'
    as _i5;
import 'package:web_translator_ml/features/home/domain/usecases/get_lenguage_usecase.dart'
    as _i7;
import 'package:web_translator_ml/features/home/domain/usecases/get_status_usecase.dart'
    as _i8;
import 'package:web_translator_ml/features/home/domain/usecases/get_translate_usecase.dart'
    as _i9;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.Client>(() => _i3.Client());
  gh.factory<_i4.TranslateDataSource>(
      () => _i4.TranslateDataSourceImpl(gh<_i3.Client>()));
  gh.factory<_i5.HomeRepository>(
      () => _i6.HomeRepositoryImpl(gh<_i4.TranslateDataSource>()));
  gh.factory<_i7.GetLenguageUseCase>(
      () => _i7.GetLenguageUseCase(gh<_i5.HomeRepository>()));
  gh.factory<_i8.GetServerStatusUseCase>(
      () => _i8.GetServerStatusUseCase(gh<_i5.HomeRepository>()));
  gh.factory<_i9.GetTranslateUseCase>(
      () => _i9.GetTranslateUseCase(gh<_i5.HomeRepository>()));
  return getIt;
}
