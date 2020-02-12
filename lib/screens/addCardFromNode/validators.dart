class Validators {

  static isValidTitle(String title) {
    return title.length >= 1 ;
  }

  static isValidContent(String content) {
    return content.length >= 3;
  }
}