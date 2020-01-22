class TopNode {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String title;
  String userRef;
  String createdAt;
  String updatedAt;
  int iV;

  TopNode(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.title,
        this.userRef,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TopNode.fromJson(Map<String, dynamic> json) {
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