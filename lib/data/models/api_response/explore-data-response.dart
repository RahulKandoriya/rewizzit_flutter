import 'package:rewizzit/data/models/models/models.dart';

class ExploreDataResponse {
  String status;
  ExploreData data;

  ExploreDataResponse({this.status, this.data});

  ExploreDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ExploreData.fromJson(json['data']) : null;
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

class ExploreData {
  List<TopNodes> topNodes;
  List<CardNodeList> cardNodeList;
  List<RecentCards> recentCards;
  List<CardModel> bookmarkedCards;
  List<RevisionCards> revisions;

  ExploreData(
      {this.topNodes,
        this.cardNodeList,
        this.recentCards,
        this.bookmarkedCards,
        this.revisions});

  ExploreData.fromJson(Map<String, dynamic> json) {
    if (json['top_nodes'] != null) {
      topNodes = new List<TopNodes>();
      json['top_nodes'].forEach((v) {
        topNodes.add(new TopNodes.fromJson(v));
      });
    }
    if (json['card_node_list'] != null) {
      cardNodeList = new List<CardNodeList>();
      json['card_node_list'].forEach((v) {
        cardNodeList.add(new CardNodeList.fromJson(v));
      });
    }
    if (json['recent_cards'] != null) {
      recentCards = new List<RecentCards>();
      json['recent_cards'].forEach((v) {
        recentCards.add(new RecentCards.fromJson(v));
      });
    }
    if (json['bookmarked_cards'] != null) {
      bookmarkedCards = new List<CardModel>();
      json['bookmarked_cards'].forEach((v) {
        bookmarkedCards.add(new CardModel.fromJson(v));
      });
    }
    if (json['rivision_cards'] != null) {
      revisions = new List<RevisionCards>();
      json['rivision_cards'].forEach((v) {
        revisions.add(new RevisionCards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topNodes != null) {
      data['top_nodes'] = this.topNodes.map((v) => v.toJson()).toList();
    }
    if (this.cardNodeList != null) {
      data['card_node_list'] =
          this.cardNodeList.map((v) => v.toJson()).toList();
    }
    if (this.recentCards != null) {
      data['recent_cards'] = this.recentCards.map((v) => v.toJson()).toList();
    }
    if (this.bookmarkedCards != null) {
      data['bookmarked_cards'] =
          this.bookmarkedCards.map((v) => v.toJson()).toList();
    }
    if (this.revisions != null) {
      data['rivision_cards'] =
          this.revisions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopNodes {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String title;
  String userRef;
  String createdAt;
  String updatedAt;
  int iV;

  TopNodes(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.title,
        this.userRef,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TopNodes.fromJson(Map<String, dynamic> json) {
    isCardNode = json['is_card_node'];
    isInRevision = json['is_in_revision'];
    sId = json['_id'];
    title = json['title'];
    userRef = json['user_ref'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_card_node'] = this.isCardNode;
    data['is_in_revision'] = this.isInRevision;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['user_ref'] = this.userRef;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CardNodeList {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String title;
  String userRef;
  Parent parent;
  String createdAt;
  String updatedAt;
  int iV;

  CardNodeList(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.title,
        this.userRef,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CardNodeList.fromJson(Map<String, dynamic> json) {
    isCardNode = json['is_card_node'];
    isInRevision = json['is_in_revision'];
    sId = json['_id'];
    title = json['title'];
    userRef = json['user_ref'];
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_card_node'] = this.isCardNode;
    data['is_in_revision'] = this.isInRevision;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['user_ref'] = this.userRef;
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Parent {
  String sId;
  String title;

  Parent({this.sId, this.title});

  Parent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}

class RecentCards {
  Image image;
  int revisionTime;
  bool isBookmarked;
  String sId;
  String title;
  String content;
  String userRef;
  ParentNode parentNode;
  String revisionRef;
  String createdAt;
  String updatedAt;
  int iV;

  RecentCards(
      {this.image,
        this.revisionTime,
        this.isBookmarked,
        this.sId,
        this.title,
        this.content,
        this.userRef,
        this.parentNode,
        this.revisionRef,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RecentCards.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    revisionTime = json['revision_time'];
    isBookmarked = json['is_bookmarked'];
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    userRef = json['user_ref'];
    parentNode = json['parent_node'] != null
        ? new ParentNode.fromJson(json['parent_node'])
        : null;
    revisionRef = json['revision_ref'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['revision_time'] = this.revisionTime;
    data['is_bookmarked'] = this.isBookmarked;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['user_ref'] = this.userRef;
    if (this.parentNode != null) {
      data['parent_node'] = this.parentNode.toJson();
    }
    data['revision_ref'] = this.revisionRef;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Image {
  String fileName;
  String url;

  Image({this.fileName, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['url'] = this.url;
    return data;
  }
}

class ParentNode {
  bool isInRevision;
  String sId;
  String title;

  ParentNode({this.isInRevision, this.sId, this.title});

  ParentNode.fromJson(Map<String, dynamic> json) {
    isInRevision = json['is_in_revision'];
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_in_revision'] = this.isInRevision;
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}

class RevisionCards {
  int cardsCompletedPerDay;
  int cardCycleCompleted;
  int daysCompleted;
  String sId;
  RecentCards revisionCard;
  String userRef;
  String createdAt;
  String updatedAt;
  int iV;
  String revisionCurrentDate;
  String revisionStartDate;

  RevisionCards(
      {this.cardsCompletedPerDay,
        this.cardCycleCompleted,
        this.daysCompleted,
        this.sId,
        this.revisionCard,
        this.userRef,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.revisionCurrentDate,
        this.revisionStartDate});

  RevisionCards.fromJson(Map<String, dynamic> json) {
    cardsCompletedPerDay = json['cards_completed_per_day'];
    cardCycleCompleted = json['card_cycle_completed'];
    daysCompleted = json['days_completed'];
    sId = json['_id'];
    revisionCard = json['revision_card'] != null
        ? new RecentCards.fromJson(json['revision_card'])
        : null;
    userRef = json['user_ref'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    revisionCurrentDate = json['revision_current_date'];
    revisionStartDate = json['revision_start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cards_completed_per_day'] = this.cardsCompletedPerDay;
    data['card_cycle_completed'] = this.cardCycleCompleted;
    data['days_completed'] = this.daysCompleted;
    data['_id'] = this.sId;
    if (this.revisionCard != null) {
      data['revision_card'] = this.revisionCard.toJson();
    }
    data['user_ref'] = this.userRef;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['revision_current_date'] = this.revisionCurrentDate;
    data['revision_start_date'] = this.revisionStartDate;
    return data;
  }
}