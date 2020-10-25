class UserModelSingleton{

  static final UserModelSingleton _userModelSingleton = UserModelSingleton._internal();
  UserModelSingleton._internal();
  factory UserModelSingleton() => _userModelSingleton;

  bool _isLoggedIn = false;
  String _username;
  String _id;
  String _account_type;
  int _media_count;

  void setLog(bool status){
    _isLoggedIn = status;
  }

  void setUserName(String username){
    _username = username;
  }

  void setId(String id){
    _id = id;
  }

  void setAccountType(String account){
    _account_type = account;
  }

  void setMidiaCount(int media){
    _media_count = media;
  }

  bool getLogStatus() => _isLoggedIn;
  String getUserName() => _username;
  String getAccountType() => _account_type;
  String getId() => _id;
  int getMediaCount() => _media_count;
}