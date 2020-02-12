class RevisionControlsGetResponse {
  String status;
  Data data;

  RevisionControlsGetResponse({this.status, this.data});

  RevisionControlsGetResponse.fromJson(Map<String, dynamic> json) {
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
  int currentRevision;
  ReviControls reviControls;

  Data({this.currentRevision, this.reviControls});

  Data.fromJson(Map<String, dynamic> json) {
    currentRevision = json['current_revision'];
    reviControls = json['revi_controls'] != null
        ? new ReviControls.fromJson(json['revi_controls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_revision'] = this.currentRevision;
    if (this.reviControls != null) {
      data['revi_controls'] = this.reviControls.toJson();
    }
    return data;
  }
}

class ReviControls {
  int cardsPerDay;
  int timesPerDay;
  int days;

  ReviControls({this.cardsPerDay, this.timesPerDay, this.days});

  ReviControls.fromJson(Map<String, dynamic> json) {
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