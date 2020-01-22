import 'package:rewizzit/data/models/models/card-model.dart';

class RevisionCardsResponse {
  String status;
  RevisionCardsData data;

  RevisionCardsResponse({this.status, this.data});

  RevisionCardsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new RevisionCardsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class RevisionCardsData {
  List<Revisions> revisions;

  RevisionCardsData({this.revisions});

  RevisionCardsData.fromJson(Map<String, dynamic> json) {
    if (json['revisions'] != null) {
      revisions = new List<Revisions>();
      json['revisions'].forEach((v) {
        revisions.add(new Revisions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.revisions != null) {
      data['revisions'] = this.revisions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Revisions {
  int cardsCompletedPerDay;
  int cardCycleCompleted;
  int daysCompleted;
  String sId;
  CardModel card;
  String userRef;
  String createdAt;
  String updatedAt;
  int iV;

  Revisions(
      {this.cardsCompletedPerDay,
        this.cardCycleCompleted,
        this.daysCompleted,
        this.sId,
        this.card,
        this.userRef,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Revisions.fromJson(Map<String, dynamic> json) {
    cardsCompletedPerDay = json['cards_completed_per_day'];
    cardCycleCompleted = json['card_cycle_completed'];
    daysCompleted = json['days_completed'];
    sId = json['_id'];
    card = json['revision_card'] != null
        ? new CardModel.fromJson(json['revision_card'])
        : null;
    userRef = json['user_ref'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cards_completed_per_day'] = this.cardsCompletedPerDay;
    data['card_cycle_completed'] = this.cardCycleCompleted;
    data['days_completed'] = this.daysCompleted;
    data['_id'] = this.sId;
    if (this.card != null) {
      data['revision_card'] = this.card.toJson();
    }
    data['user_ref'] = this.userRef;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}