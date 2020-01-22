import 'package:rewizzit/data/models/models/node.dart';

class SubNodesResponse {
  String status;
  SubNodesData data;

  SubNodesResponse({this.status, this.data});

  SubNodesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SubNodesData.fromJson(json['data']) : null;
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

class SubNodesData {
  List<Node> nodes;

  SubNodesData({this.nodes});

  SubNodesData.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = new List<Node>();
      json['nodes'].forEach((v) {
        nodes.add(new Node.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodes != null) {
      data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}