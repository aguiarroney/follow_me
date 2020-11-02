class UserModelSingleton{

  static final UserModelSingleton _userModelSingleton = UserModelSingleton._internal();
  UserModelSingleton._internal();
  factory UserModelSingleton() => _userModelSingleton;

  bool _isLoggedIn = false;
  String _username;
  String _id;
  String _account_type;
  int _media_count;
  String _userToken;
  List<String> _midiaUrls = [];

  void setToken(String token){
    _userToken = token;
  }

  String getToken(){
    return _userToken;
  }

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

  void addMidiaUrls(String id){

    if(_midiaUrls == null)
      _midiaUrls = List<String>();

    _midiaUrls.add(id);
  }

  bool getLogStatus() => _isLoggedIn;
  String getUserName() => _username;
  String getAccountType() => _account_type;
  String getId() => _id;
  int getMediaCount() => _media_count;
  String getMidiaUrls(int index) {
    return _midiaUrls[index];
  }
}