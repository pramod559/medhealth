class BASEURL {
  static String ipAddress = "192.168.232.192";

  static Uri apiRegister =
      Uri.parse("http://$ipAddress/medhealth_db/register_api.php");
  static Uri apiLogin =
      Uri.parse("http://$ipAddress/medhealth_db/login_api.php");
  static Uri categoryWithProduct =
      Uri.parse("http://$ipAddress/medhealth_db/get_product_with_category.php");
  static Uri getProduct =
      Uri.parse("http://$ipAddress/medhealth_db/get_product.php");
}


// class BASEURL {
//   static String ipAddress = "192.168.232.192";
//   static String apiRegister = "http://$ipAddress/medhealth_db/register_api.php";
//   static String apiLogin = "http://$ipAddress/medhealth_db/login_api.php";
//   static String categoryWithProduct =
//       "http://$ipAddress/medhealth_db/get_product_with_category.php";
//   static String getProduct = "http://$ipAddress/medhealth_db/get_product.php";
// }
