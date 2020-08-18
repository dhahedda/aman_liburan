// import 'dart:convert';
// import 'package:ameera_v2/model/stock/stok_adjustment_item_object.dart';
// import 'package:ameera_v2/model/stock/variant_summary_object.dart';
// import 'package:ameera_v2/util/sync_service.dart';
// import 'package:meta/meta.dart';

// class StockRepository {
//   //1.Variant Summary (GET)
//   Future<List<VariantSummaryObject>> getAllVariantSummaryByStore({@required int storeId}) async {
//     var response = await SyncService().httpGetHelper('/master/stok/item/getAllVariantSummaryByStore?id=' + storeId.toString(), 'getAllVariantSummaryByStore');

//     List<VariantSummaryObject> variantSummaryObject = [];
//     List<VariantSummaryObject> listObject = List<VariantSummaryObject>.from(jsonDecode(response.body).map((_) => VariantSummaryObject.fromJson(_)));
//     listObject.forEach((_) {
//       variantSummaryObject.add(_);
//     });

//     return variantSummaryObject;
//   }

//   //2.Stok Adjustment Item (POST)
//   Future<Map<String, dynamic>> addStokAdjustmentItem({@required StokAdjustmentItemObject stokAdjustmentItemObject}) async {
//     try {
//       var response = await SyncService().httpPostHelper('/transaction/stok/adjustment/item/add', stokAdjustmentItemObject.toJson(), 'addStokAdjustmentItem');
//       return jsonDecode(response.body);
//     } catch (e) {
//       return {
//         'status': false,
//         'message': 'Server Error',
//       };
//     }
//   }
// }
