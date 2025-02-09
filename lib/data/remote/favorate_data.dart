// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/my_classes/crud.dart';

// class Favorite_data {
//   Crud crud = Crud();

//   getFavorite(int userid) async {
//     var res = await crud.getrequst("$favoriteList/$userid/");
//     return res.fold((l) => l, (r) => r);
//   }

//   removeFavorite(int productId, int userid) async {
//     var res = await crud.deleteRequest("$delete_Fav/$productId/$userid/");
//     return res.fold((l) => l, (r) => r);
//   }

//   addFavorite(int productId, int userid) async {
//     var res = await crud
//         .postrequst(insert_Fav, {"user_fk": "$userid", "pr_fk": "$productId"});
//     return res.fold((l) => l, (r) => r);
//   }
// }
