class CardNodesResponse {
  String status;
  List<CardsNodesData> data;

  CardNodesResponse({this.status, this.data});

  CardNodesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CardsNodesData>();
      json['data'].forEach((v) {
        data.add(new CardsNodesData.fromJson(v));
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

class CardsNodesData {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String title;
  String userRef;
  String parent;
  String createdAt;
  String updatedAt;
  int iV;

  CardsNodesData(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.title,
        this.userRef,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CardsNodesData.fromJson(Map<String, dynamic> json) {
    isCardNode = json['is_card_node'];
    isInRevision = json['is_in_revision'];
    sId = json['_id'];
    title = json['title'];
    userRef = json['user_ref'];
    parent = json['parent'];
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
    data['parent'] = this.parent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}