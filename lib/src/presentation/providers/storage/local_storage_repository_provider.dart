import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/datasources/local_storage_datasource.dart';
import 'package:movies_app/src/infraestructure/datasources/isar_datasource.dart';
import 'package:movies_app/src/infraestructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  LocalStorageDatasource datasource = IsarDatasource();
  return LocalStorageRepositoryImpl(datasource);
});
