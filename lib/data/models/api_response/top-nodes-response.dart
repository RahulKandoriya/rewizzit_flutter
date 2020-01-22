import 'package:rewizzit/data/models/models/top-node.dart';

class TopNodesResponse {
  String status;
  List<TopNode> data;

  TopNodesResponse({this.status, this.data});

  TopNodesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<TopNode>();
      json['data'].forEach((v) {
        data.add(new TopNode.fromJson(v));
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

