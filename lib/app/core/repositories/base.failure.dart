import 'package:iva_app/app/core/errors/failures.dart';

class BaseFailure extends Failure {
  @override
  final String message;

  BaseFailure({required this.message});
}
