// data/repositories/link_repository_impl.dart
import '../../core/either/either.dart';
import '../../core/error/failure.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/link_entity.dart';
import '../../domain/repositories/link_repository.dart';
import '../datasources/link_local_datasource.dart';
import '../models/link_model.dart';

class LinkRepositoryImpl implements LinkRepository {
  final LinkLocalDataSource localDataSource;

  LinkRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addLink(LinkEntity link) async {
    try {
      await localDataSource.insertLink(LinkModel.fromEntity(link));
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LinkEntity>>> getAllLinks() async {
    try {
      final models = await localDataSource.getAllLinks();
      return Right(models.map((m) => m.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }

  @override
  Future<Either<Failure, LinkEntity?>> getLinkById(int id) async {
    try {
      final model = await localDataSource.getLinkById(id);
      return Right(model?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateLink(LinkEntity link) async {
    try {
      await localDataSource.updateLink(LinkModel.fromEntity(link));
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLink(int id) async {
    try {
      await localDataSource.deleteLink(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LinkEntity>>> searchLinks(String query) async {
    try {
      final results = await localDataSource.searchLinks(query);
      return Right(results.map((m) => m.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure.userFriendly(e.message));
    }
  }
}
