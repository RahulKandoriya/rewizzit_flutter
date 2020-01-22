import 'package:rewizzit/data/models/models/card-model.dart';

class BookmarkCardsResponse {
  String status;
  List<CardModel> data;

  BookmarkCardsResponse({this.status, this.data});

  BookmarkCardsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CardModel>();
      json['data'].forEach((v) {
        data.add(new CardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}