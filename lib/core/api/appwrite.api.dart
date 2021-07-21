import 'package:afrocom/app/constants/appwrite.credentials.dart';
import 'package:afrocom/core/models/user.model.dart';
import 'package:afrocom/meta/utilities/navigation.utility.dart';
import 'package:afrocom/meta/views/authentication/login/login.exports.dart';
import 'package:appwrite/appwrite.dart';

class AppwriteAPI {
  static AppwriteAPI? _instance;
  late Client _client;
  late Database _database;
  late Storage _storage;
  late Account _account;
  final NavigationUtility navigationUtility = new NavigationUtility();
  AppwriteAPI._initialize() {
    _client = Client(
      endPoint: AppwriteCredentials.AppwriteEndpoint,
    ).setProject(AppwriteCredentials.AppwriteProjectID).setSelfSigned();
    _account = Account(_client);
    _database = Database(_client);
    _storage = Storage(_client);
  }
  static AppwriteAPI get createInstance {
    if (_instance == null) {
      _instance = AppwriteAPI._initialize();
    }
    return _instance!;
  }

  //! Authentication
  Future signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      var response =
          await _account.create(name: name, email: email, password: password);
      var res = User.fromMap(response.data);
      print(res.toJson());
      return res.toJson();
    } on AppwriteException catch (error) {
      print(error.message);
      SnackbarUtility.showSnackbar(context: context, message: error.message!);
    } catch (error) {
      print(error);
    }
  }

  Future login({required String email, required String password}) async {
    try {
      var response =
          await _account.createSession(email: email, password: password);
      print(response.data);
    } on AppwriteException catch (error) {
      print(error.message);
    }
  }

  Future getUser(BuildContext context) async {
    dynamic res;
    try {
      res = await _account.get();
      var user = User.fromMap(res.data);
      SnackbarUtility.showSnackbar(
          context: context, message: "${user.name} has logged in");
      return user;
    } on AppwriteException catch (e) {
      SnackbarUtility.showSnackbar(context: context, message: e.message!);
    }
  }

  Future logOut(BuildContext context) async {
    await _account.deleteSession(sessionId: "current").whenComplete(() {
      navigationUtility.navigateTo(context, LoginRoute);
    });
  }

  //! Database
  Future addData({required dynamic data, required String collectionId}) async {
    await _database.createDocument(collectionId: collectionId, data: data);
  }
}