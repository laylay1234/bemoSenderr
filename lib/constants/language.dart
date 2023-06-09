// this class will contain the list of languages

class LanguageSelector {
  static String select(String language) {
    switch (language) {
      case "English":
        return "en";
      case "French":
        return "fr";
      default:
        return "N/A";
    }
  }

  static List<String> languageList = ["English", "French"];
}
