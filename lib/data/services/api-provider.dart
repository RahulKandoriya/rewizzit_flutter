import 'dart:convert';
import 'dart:io';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/api_response/bookmark-cards-response.dart';
import 'package:rewizzit/data/models/models/models.dart';
import 'package:rewizzit/data/models/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rewizzit/data/services/api-base-helper.dart';

class ApiProvider {

  String baseUrl = "https://rewizzit.api.cofeelia.com/";
  String googleBooksBaseUrl  = "https://www.googleapis.com/books/v1/volumes?q=";
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
  Future<List<CardModel>> fetchBookmarkCardsList() async {
    final response = await _helper.get("card-bookmark");
    return BookmarkCardsResponse.fromJson(response).data;
  }

  Future<List<TopNode>> fetchTopNodesList() async {
    final response = await _helper.get("organize");
    return TopNodesResponse.fromJson(response).data;
  }

  Future<List<Node>> fetchSubNodesList(String nodeId) async {
    final response = await _helper.get("sub-nodes/$nodeId");
    return SubNodesResponse.fromJson(response).data.nodes;
  }

  Future<List<CardModel>> fetchNodeCardsList(String nodeId) async {
    final response = await _helper.get("sub-nodes/$nodeId");
    return NodeCardsResponse.fromJson(response).data.cards;
  }


  Future<bool> addNode(String title, bool isCardNode, String parent) async {
    final response = await http.post(baseUrl + "add-node", body: {'title': title, 'is_card_node' : isCardNode, 'parent': parent});
    return response != null;
  }

  Future<bool> addCard(String title, String content, String parent, File image) async {
    final response = await http.post(baseUrl + "new-card", body: {'title': title, 'content' : content, 'parent_node': parent, 'cardImage': image });
    return response != null;
  }




}