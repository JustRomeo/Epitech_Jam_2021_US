class Requests {
    // Host
    static String host = "https://10.0.2.2:3000";

    // Services
    static String user = "/user";
    static String appli = "/application";

    // Request
    static String create = host + user + "/create";
    static String connect = host + user + "/connect";
    static String getShop = host + appli + "/getShop";
    static String addValue = host + user + "/addValue";
    static String appInfos = host + appli + "/getInfos";
    static String setLanguage = host + user + "/setLanguage";
    static String getPublications = host + appli + "/getPublications";
}