class User {
  String uName;
  String uEmail;
  String uPicture;
  String authorizeToken;

  User({this.uName, this.uEmail, this.uPicture, this.authorizeToken});

  User.fromJson(Map<String, dynamic> json) {
    uName = json['uName'];
    uEmail = json['uEmail'];
    uPicture = json['uPicture'];
    authorizeToken = json['Authorize_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uName'] = this.uName;
    data['uEmail'] = this.uEmail;
    data['uPicture'] = this.uPicture;
    data['Authorize_token'] = this.authorizeToken;
    return data;
  }
}