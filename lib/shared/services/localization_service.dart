class LocalizationService {
  static String _currentLanguage = 'es';
  
  static final Map<String, Map<String, String>> _translations = {
    'es': {
      'community': 'Comunidad',
      'myLeader': 'Mi Líder',
      'myTeam': 'Mi Equipo',
      'members': 'miembros',
      'ranking': 'Ranking',
      'feed': 'Feed',
      'createPost': 'Crear Publicación',
      'share': 'Compartir',
      'like': 'Me gusta',
      'comment': 'Comentar',
      'leader': 'Líder',
      'level': 'Nivel',
      'active': 'Activo hace',
      'inviteMoreFriends': 'Invita más amigos',
      'shareReferralCode': 'Comparte tu código de referido',
      'shareCode': 'Compartir Código',
    },
    'en': {
      'community': 'Community',
      'myLeader': 'My Leader',
      'myTeam': 'My Team',
      'members': 'members',
      'ranking': 'Ranking',
      'feed': 'Feed',
      'createPost': 'Create Post',
      'share': 'Share',
      'like': 'Like',
      'comment': 'Comment',
      'leader': 'Leader',
      'level': 'Level',
      'active': 'Active',
      'inviteMoreFriends': 'Invite more friends',
      'shareReferralCode': 'Share your referral code',
      'shareCode': 'Share Code',
    },
  };
  
  static String getText(String key) {
    return _translations[_currentLanguage]?[key] ?? key;
  }
  
  static void setLanguage(String language) {
    _currentLanguage = language;
  }
  
  static String getCurrentLanguage() {
    return _currentLanguage;
  }
}