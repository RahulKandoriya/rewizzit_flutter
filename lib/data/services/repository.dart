import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/api_response/explore-data-response.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-get-response.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-post-response.dart';
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

  Future<ExploreData> fetchExploreDataList() async {
    return await _apiProvider.fetchExploreDataList();
  }

  Future<List<CardModel>> fetchBookmarkCards() async {
    return await _apiProvider.fetchBookmarkCardsList();
  }

  Future<List<RecentCards>> fetchRecentCards() async {
    return await _apiProvider.fetchRecentCardsList();
  }

  Future<SubNodesResponse> fetchTopNodesList() async {
    return await _apiProvider.fetchTopNodesList();
  }

  Future<SubNodesResponse> fetchSubNodesList(String parentNodeId) async {
    return await _apiProvider.fetchSubNodesList(parentNodeId);
  }

  Future<NodeCardsResponse> fetchNodeCardsList(String parentNodeId) async {
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

  Future<String> updateCardToRevision(String reviId) async {
    return await _apiProvider.updateCardToRevision(reviId);
  }

  Future<String> deleteCard(String cardId) async {
    return await _apiProvider.deleteCard(cardId);
  }

  Future<String> deleteNode(String nodeId) async {
    return await _apiProvider.deleteNode(nodeId);
  }

  Future<void> addNode(String title, bool isCardNode, String parentNode) async {
    return await _apiProvider.addNode(title, isCardNode,parentNode);
  }

  Future<void> editNode(String title, String nodeId) async {
    return await _apiProvider.editNode(title, nodeId);
  }

  Future<void> addCard(String title, String content, String parentNodeId) async {
    return await _apiProvider.addCard(title, content, parentNodeId);
  }

  Future<void> editCard(String title, String content, String parentNodeId, String cardId) async {
    return await _apiProvider.editCard(title, content, parentNodeId, cardId);
  }

  Future<RevisionControlsPostResponse> setRevisionControls(int cardsPerDay, int timesPerDay, int days) async {
    return await _apiProvider.setRevisionControls(cardsPerDay, timesPerDay, days);
  }

  Future<RevisionControlsGetResponse> getRevisionControls() async {
    return await _apiProvider.getRevisionControls();
  }
}