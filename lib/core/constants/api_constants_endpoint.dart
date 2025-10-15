class ApiConstants {
  static const String baseUrl = 'https://progres.mesrs.dz/api/';
  static const String loginEndpoint = 'authentication/v1/';
  static String userDiasInfoEndpoint(String uuid) {
    return 'infos/bac/$uuid/dias';
  }

  static String userImageEndpoint(String uuid) {
    return 'infos/image/$uuid';
  }

  static String userGroupEndpoint(String diasId) {
    return 'infos/dia/$diasId/groups';
  }

  static String userNoteExamsEndpoint(String diasId) {
    return 'infos/planningSession/dia/$diasId/noteExamens';
  }

  static String userAcademicTranscriptsEndpoint(String diasId, String uuid) {
    return 'infos/bac/$uuid/dias/$diasId/periode/bilans';
  }

  static String UserAccommodationEndpint(String uuid) {
    return 'infos/bac/$uuid/demandesHebregement';
  }

  static String timeTableEndpoint(String diasId) {
    return 'infos/seanceEmploi/inscription/$diasId';
  }

  static String examsTimeTableEndpoint(String diasId) {
    return 'infos/Examens/{{ouvertureOffreFormationId}}/niveau/{{niveauId}}/examens';
  }

  static String modulesPercentageEndpoint(String diasId) {
    return 'infos/offreFormation/{{ouvertureOffreFormationId}}/niveau/{{niveauId}}/Coefficients';
  }
}
