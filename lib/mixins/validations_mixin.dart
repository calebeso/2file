mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Este campo é obrigatório";

    return null;
  }

  String? isCategoriaNotEmpty(value, [String? message]) {
    if (value == null) return message ?? "Este campo é obrigatório";

    return null;
  }

  String? isCompetenciaMenor(value, datacomp, [String? message]) {
    bool validacaoData = value!.isBefore(datacomp!);

    if (validacaoData == true)
      return message ??
          "Data de Validade deve ser maior que Data de Competencia";

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
