enum StatusViagemParticipanteEnum {
  pendente(1, 'Pendente'),
  aceito(2, 'Aceito'),
  recusado(3, 'Recusado');

  final int numero;
  final String descricao;
  const StatusViagemParticipanteEnum(this.numero, this.descricao);

  static StatusViagemParticipanteEnum? fromNumero(int? numero) {
    if (numero == null) return null;
    return StatusViagemParticipanteEnum.values.firstWhere(
      (e) => e.numero == numero,
      orElse: () => StatusViagemParticipanteEnum.pendente,
    );
  }
}
