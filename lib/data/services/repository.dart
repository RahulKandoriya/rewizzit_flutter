import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewizzit/data/models/api_response/add-node-response.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/models/models.dart';
import 'package:rewizzit/data/models/models/user.dart';
import 'package:rewizzit/data/services/api-provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final GoogleSignIn _googleSignIn;
  ApiProvider _apiProvider;
  SharedPreferences prefs;

  Repository({GoogleSignIn googleSignIn, ApiProvider apiProvider})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _apiProvider = apiProvider ?? ApiProvider();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    return await _apiProvider.fetchUser(googleAuth.idToken);
  }


  Future<void> signOut() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    return Future.wait([
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    prefs = await SharedPreferences.getInstance();
    return (await _googleSignIn.isSignedIn()) || (prefs.getString("user") != null);
  }

  Future<List<Revisions>> fetchRevisionCards() async {
    return await _apiProvider.fetchRevisionCardsList();
  }

  Future<List<CardModel>> fetchBookmarkCards() async {
    return await _apiProvider.fetchBookmarkCardsList();
  }

  Future<List<TopNode>> fetchTopNodesList() async {
    return await _apiProvider.fetchTopNodesList();
  }

  Future<List<Node>> fetchSubNodesList(String parentNodeId) async {
    return await _apiProvider.fetchSubNodesList(parentNodeId);
  }

  Future<List<CardModel>> fetchNodeCardsList(String parentNodeId) async {
    return await _apiProvider.fetchNodeCardsList(parentNodeId);
  }

  Future<List<CardsNodesData>> fetchCardNodesList() async {
    return await _apiProvider.fetchCardNodesList();
  }

  Future<String> addCardToBookmark(String cardId) async {
    return await _apiProvider.addCardToBookmark(cardId);
  }

  Future<String> addCardToRevision(String cardId) async {
    return await _apiProvider.addCardToRevision(cardId);
  }

  Future<void> addNode(String title, bool isCardNode, String parentNode) async {
    return await _apiProvider.addNode(title, isCardNode,parentNode);
  }

  Future<void> addCard(String title, String content, String parentNodeId) async {
    return await _apiProvider.addCard(title, content, parentNodeId);
  }
}