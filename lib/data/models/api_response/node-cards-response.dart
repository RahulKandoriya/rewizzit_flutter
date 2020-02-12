import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/models/models/cur-node.dart';

class NodeCardsResponse {
  String status;
  NodeCardsData data;
  CurNode curNode;

  NodeCardsResponse({this.status, this.data, this.curNode});

  NodeCardsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    curNode = json['cur_node']!= null ? new CurNode.fromJson(json['cur_node']) : null;
    data = json['data'] != null ? new NodeCardsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['cur_node'] = this.curNode.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class NodeCardsData {
  List<CardModel> cards;

  NodeCardsData({this.cards});

  NodeCardsData.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = new List<CardModel>();
      json['cards'].forEach((v) {
        cards.add(new CardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
