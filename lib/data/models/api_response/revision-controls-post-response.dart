class RevisionControlsPostResponse {
  String status;
  Data data;

  RevisionControlsPostResponse({this.status, this.data});

  RevisionControlsPostResponse.fromJson(Map<String, dynamic> json) {
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
  int cardsPerDay;
  int timesPerDay;
  int days;

  Data({this.cardsPerDay, this.timesPerDay, this.days});

  Data.fromJson(Map<String, dynamic> json) {
    cardsPerDay = json['cards_per_day'];
    timesPerDay = json['times_per_day'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cards_per_day'] = this.cardsPerDay;
    data['times_per_day'] = this.timesPerDay;
    data['days'] = this.days;
    return data;
  }
}