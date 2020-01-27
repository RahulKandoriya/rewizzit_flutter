class Validators {

  static isValidTitle(String title) {
    return title.length >= 1 && title.length <= 30;
  }

  static isValidContent(String content) {
    return content.length >= 3 && content.length <= 300;
  }
}