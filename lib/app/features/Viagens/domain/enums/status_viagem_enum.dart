enum StatusViagemEnum {
  planejada,
  emAndamento,
  finalizada,
  cancelada,
}

extension StatusViagemEnumExtension on StatusViagemEnum {
  int get numero {
    switch (this) {
      case StatusViagemEnum.planejada:
        return 1;
      case StatusViagemEnum.emAndamento:
        return 2;
      case StatusViagemEnum.finalizada:
        return 3;
      case StatusViagemEnum.cancelada:
        return 4;
    }
  }

  String get descricao {
    switch (this) {
      case StatusViagemEnum.planejada:
        return 'Planejada';
      case StatusViagemEnum.emAndamento:
        return 'Em andamento';
      case StatusViagemEnum.finalizada:
        return 'Finalizada';
      case StatusViagemEnum.cancelada:
        return 'Cancelada';
    }
  }
}
