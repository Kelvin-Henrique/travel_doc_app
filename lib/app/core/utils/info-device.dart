import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/utils/info-device.entity.dart';

class InfoDeviceUtils {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Either<Failure, InfoDeviceEntity>> getInfoDeviceAsync() async {
    try {
      InfoDeviceEntity deviceData = InfoDeviceEntity();

      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }

      return Right(deviceData);
    } on PlatformException {
      return Left(DeviceInfoFailure(
          message: "Erro ao obter informações do dispositivo!"));
    }
  }

  static InfoDeviceEntity _readAndroidBuildData(AndroidDeviceInfo build) {
    return InfoDeviceEntity(
      versaoSistema: build.version.sdkInt.toString(),
      modelo: build.model,
      idFisico: build.id,
    );
  }

  static InfoDeviceEntity _readIosDeviceInfo(IosDeviceInfo data) {
    return InfoDeviceEntity(
      versaoSistema: data.systemVersion,
      modelo: data.model,
      idFisico: data.identifierForVendor ?? '',
    );
  }
}

class DeviceInfoFailure extends Failure {
  @override
  final String message;
  DeviceInfoFailure({required this.message});
}
