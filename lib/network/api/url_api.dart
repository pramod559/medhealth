class BASEURL {
  static String ipAddress = "192.168.102.192";

  // static Uri _buildUri(String path) {
  //   return Uri.http(ipAddress, path);
  // }

  static String apiRegister = "http://$ipAddress/medhealth_db/register_api.php";
  static String apiLogin = "http://$ipAddress/medhealth_db/login_api.php";
  static String categoryWithProduct =
      "http://$ipAddress/medhealth_db/get_product_with_category.php";
  static String getProduct = "http://$ipAddress/medhealth_db/get_product.php";
  static String addToCart = "http://$ipAddress/medhealth_db/add_to_cart.php";
  static String getProductCart =
      "http://$ipAddress/medhealth_db/get_cart.php?userID=";
  static String updateQuantityProductCart =
      "http://$ipAddress/medhealth_db/update_quantity.php";
  static String totalPriceCart =
      "http://$ipAddress/medhealth_db/get_total_price.php?userID=";
  static String getTotalCart =
      "http://$ipAddress/medhealth_db/total_cart.php?userID=";
  static String checkout = "http://$ipAddress/medhealth_db/checkout.php";

  static String historyOrder =
      "http://$ipAddress/medhealth_db/get_history.php?id_user=";

  // static Uri getProductCartt(String userID) {
  //   return _buildUri("/medhealth_db/get_cart.php?userID=$userID");
  // }

  // static String getProductCart(String userID) =
  //     "http://$ipAddress/medhealth_db/get_cart.php?userID=$userID";
}


// class BASEURL {
//   static String ipAddress = "192.168.232.192";
  // static Uri apiRegister =
  //     Uri.parse("http://$ipAddress/medhealth_db/register_api.php");
  // static Uri apiLogin =
  //     Uri.parse("http://$ipAddress/medhealth_db/login_api.php");
  // static Uri categoryWithProduct =
  //     Uri.parse("http://$ipAddress/medhealth_db/get_product_with_category.php");
  // static Uri getProduct =
  //     Uri.parse("http://$ipAddress/medhealth_db/get_product.php");


// }
