class Validators {

  static isValidTitle(String title) {
    return title.length >= 1 && title.length <= 20;
  }
}