import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:iva_app/app/core/errors/exceptions.dart';
import 'package:iva_app/app/core/errors/failures.dart';
import 'package:iva_app/app/core/platform/network-info/inetwork-info.dart';
import 'package:iva_app/app/core/repositories/base.failure.dart';

class BaseRepository {
  final INetworkInfo networkInfo;

  BaseRepository({required this.networkInfo});

  Future<Either<Failure, T>> executeSafely<T>(
      Future<T> Function() operation) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await operation();
        return Right(result);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException catch (e) {
      return Left(BaseFailure(message: e.message));
    } on FormatException catch (e) {
      return Left(BaseFailure(message: e.message));
    } on OfflineFailure {
      return Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(BaseFailure(
          message:
              e.error?.toString() ?? "Erro ao tentar realizar a requisição"));
    } catch (e) {
      return Left(ErrorFailure());
    }
  }
}
