class AddNodeResponse {
  String status;
  Data data;

  AddNodeResponse({this.status, this.data});

  AddNodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  bool isCardNode;
  bool isInRevision;
  String sId;
  String parent;
  String title;
  String userRef;
  String createdAt;
  String updatedAt;
  int iV;

  Data(
      {this.isCardNode,
        this.isInRevision,
        this.sId,
        this.parent,
        this.title,
        this.userRef,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    isCardNode = json['is_card_node'];
    isInRevision = json['is_in_revision'];
    sId = json['_id'];
    parent = json['parent'];
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
    data['parent'] = this.parent;
    data['title'] = this.title;
    data['user_ref'] = this.userRef;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}