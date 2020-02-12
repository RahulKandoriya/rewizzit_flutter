import 'dart:convert';
import 'package:rewizzit/data/models/api_response/add-node-response.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/api_response/bookmark-cards-response.dart';
import 'package:rewizzit/data/models/api_response/bookmark-response.dart';
import 'package:rewizzit/data/models/api_response/explore-data-response.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-get-response.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-post-response.dart';
import 'package:rewizzit/data/models/api_response/revision-response.dart';
import 'package:rewizzit/data/models/models/models.dart';
import 'package:rewizzit/data/models/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rewizzit/data/services/api-base-helper.dart';

class ApiProvider {

  String baseUrl = "https://rewizzit.api.cofeelia.com/";
  final successCode = 200;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> fetchUser(String idToken) async {
    final response = await http.post(baseUrl + "sign-in", body: {'idtoken': idToken} );
    return parseResponse(response);
  }

  User parseResponse(http.Response response) {
    final responseString = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      return User.fromJson(responseString);
    } else {
      throw Exception('failed to load User');
    }
  }

  Future<List<Revisions>> fetchRevisionCardsList() async {
    final response = await _helper.get("revision-home");
    return RevisionCardsResponse.fromJson(response).data.revisions;
  }

  Future<ExploreData> fetchExploreDataList() async {
    final response = await _helper.get("explore");
    return ExploreDataResponse.fromJson(response).data;
  }

  Future<List<CardModel>> fetchBookmarkCardsList() async {
    final response = await _helper.get("card-bookmark");
    return BookmarkCardsResponse.fromJson(response).data;
  }

  Future<List<RecentCards>> fetchRecentCardsList() async {
    final response = await _helper.get("explore");
    return ExploreDataResponse.fromJson(response).data.recentCards;
  }

  Future<SubNodesResponse> fetchTopNodesList() async {
    final response = await _helper.get("sub-nodes");
    return SubNodesResponse.fromJson(response);
  }

  Future<SubNodesResponse> fetchSubNodesList(String nodeId) async {
    final response = await _helper.get("sub-nodes/$nodeId");
    return SubNodesResponse.fromJson(response);
  }


  Future<List<CardsNodesData>> fetchCardNodesList() async {
    final response = await _helper.get("list-card-nodes");
    return CardNodesResponse.fromJson(response).data;
  }

  Future<NodeCardsResponse> fetchNodeCardsList(String nodeId) async {
    final response = await _helper.get("sub-nodes/?id=$nodeId");
    return NodeCardsResponse.fromJson(response);
  }

  Future<String> addCardToBookmark(String cardId) async {
    final response = await _helper.post("card-bookmark", {'card_id': cardId});
    return BookmarkResponse.fromJson(response).data;
  }

  Future<String> addCardToRevision(String cardId) async {
    final response = await _helper.post("add-card-revision", {'card_id': cardId});
    return RevisionResponse.fromJson(response).data;
  }

  Future<String> updateCardToRevision(String revi_id) async {
    final response = await _helper.post("update-current-card-revision", {'revi_id': revi_id});
    return RevisionResponse.fromJson(response).data;
  }

  Future<String> deleteCard(String cardId) async {
    final response = await _helper.post("card-delete", {'card_id': cardId});
    return RevisionResponse.fromJson(response).data;
  }

  Future<String> deleteNode(String nodeId) async {
    final response = await _helper.post("delete-node", {'node_id': nodeId});
    return RevisionResponse.fromJson(response).data;
  }


  Future<void> addNode(String title, bool isCardNode, String parent) async {
    return await _helper.post("add-node", {'title': title, 'is_card_node' : isCardNode, 'parent': parent});
  }

  Future<void> editNode(String title, String nodeId) async {
    return await _helper.post("edit-node", {'title': title, 'node_id': nodeId});
  }

  Future<void> addCard(String title, String content, String parent) async {
    return await _helper.postData({'title': title, 'content' : content, 'parent_node': parent, 'cardImage': null});
  }

  Future<void> editCard(String title, String content, String parent, String cardId) async {
    return await _helper.editCardData({'card_id': cardId,'title': title, 'content' : content, 'parent_node': parent, 'cardImage': null});
  }

  Future<RevisionControlsPostResponse> setRevisionControls(int cardsPerDay, int timesPerDay, int days) async {
    final response = await _helper.post("revision-controls", {'cards_per_day': cardsPerDay, 'times_per_day' : timesPerDay, 'days': days});
    return RevisionControlsPostResponse.fromJson(response);
  }

  Future<RevisionControlsGetResponse> getRevisionControls() async {
    final response = await _helper.get("revision-controls");
    return RevisionControlsGetResponse.fromJson(response);
  }



}