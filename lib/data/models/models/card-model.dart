class CardModel {
  CardImage image;
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

  CardModel(
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

  CardModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new CardImage.fromJson(json['image']) : null;
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

class CardImage {
  String fileName;
  String url;

  CardImage({this.fileName, this.url});

  CardImage.fromJson(Map<String, dynamic> json) {
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