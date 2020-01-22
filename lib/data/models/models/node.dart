class Node {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String title;
  String userRef;
  Parent parent;
  String createdAt;
  String updatedAt;
  int iV;

  Node(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.title,
        this.userRef,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Node.fromJson(Map<String, dynamic> json) {
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
  bool isInRevision;
  String sId;
  String title;

  Parent({this.isInRevision, this.sId, this.title});

  Parent.fromJson(Map<String, dynamic> json) {
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