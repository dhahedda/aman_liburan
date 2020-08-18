// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:ui';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:aman_liburan/models/carousel_model.dart';
// import 'package:aman_liburan/models/catalog_model.dart';
// import 'package:aman_liburan/models/param/add_product_param.dart';
// import 'package:aman_liburan/models/response/api_response.dart';
// import 'package:aman_liburan/screens/account/account_seller_page.dart';
// import 'package:aman_liburan/screens/add_product/add_product_4th_page.dart';
// import 'package:aman_liburan/screens/create_appointment/create_appointment_page.dart';
// import 'package:aman_liburan/utilities/size_config.dart';
// import 'package:aman_liburan/utilities/styles/custom_styles.dart';
// import 'package:aman_liburan/utilities/widgets/circle_button.dart';
// import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';
// import 'package:aman_liburan/blocs/detail_product/detail_product_bloc.dart';
// import 'package:image/image.dart' as image;
// import 'package:path_provider/path_provider.dart';

// import 'add_product_full_screen_carousel_page.dart';

// class AddProduct3rdPage extends StatelessWidget {
//   final String productId;
//   final bool androidFusedLocation;

//   AddProduct3rdPage({this.productId, this.androidFusedLocation});

//   final TextEditingController _itemNameController = TextEditingController();
//   final TextEditingController _brandNameController = TextEditingController();
//   final TextEditingController _itemConditionController = TextEditingController();
//   final TextEditingController _modelNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   final ImagePicker picker = ImagePicker();
//   List<File> _listImageFiles = [];
//   List<String> _listImageBase64 = [];
//   List<String> _listThumbnailBase64 = [];

//   AddProductParam _addProductParam;
//   String _yearsOwned;

//   void printWrapped(String text) {
//     final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
//     pattern.allMatches(text).forEach((match) => print(match.group(0)));
//   }

//   String _randomString(int length) {
//     var rand = Random();
//     var codeUnits = List.generate(length, (index) {
//       return rand.nextInt(33) + 89;
//     });

//     return String.fromCharCodes(codeUnits);
//   }

//   void makeAppointmentPressed(GlobalResponse response, BuildContext context, String distanceProduct) {
//     Navigator.of(context).pop();
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CreateAppointmentPage(
//           response: response,
//           distanceProduct: distanceProduct,
//         ),
//       ),
//     );
//   }

//   void onButtonAppointmentPressed(GlobalResponse response, BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           color: Color(0xFF737373),
//           height: 250,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(15.0),
//                 topRight: const Radius.circular(15.0),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Make Appointment"),
//                 ),
//                 HorizontalLine(
//                   width: double.infinity,
//                   color: Colors.grey.withOpacity(.6),
//                   padding: 0.0,
//                 ),
//                 // Make Appointment
//                 GestureDetector(
//                   onTap: () {
//                     String distanceProduct = "0.3km away";
//                     makeAppointmentPressed(response, context, distanceProduct);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Icon(
//                             Icons.supervised_user_circle,
//                             size: 32.0,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 8,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Create Appointment",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1,
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w800,
//                                   fontFamily: "Nunito",
//                                 ),
//                               ),
//                               Text(
//                                 "Set a schedule to meet with owner",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: "Nunito",
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Take Away
//                 GestureDetector(
//                   onTap: () {
//                     print("Take Away Clicked!");
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Icon(
//                             Icons.touch_app,
//                             size: 32.0,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 8,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Take Away",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1,
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w800,
//                                   fontFamily: "Nunito",
//                                 ),
//                               ),
//                               Text(
//                                 "It’s ok, I will pick-up the item myself",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: "Nunito",
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Deliver to me
//                 GestureDetector(
//                   onTap: () {
//                     print("Deliver to me Clicked!");
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Icon(
//                             Icons.departure_board,
//                             size: 32.0,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 8,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Deliver to me",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1,
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w800,
//                                   fontFamily: "Nunito",
//                                 ),
//                               ),
//                               Wrap(
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Text(
//                                     "Send it via courier to my place",
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       letterSpacing: 1,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w400,
//                                       fontFamily: "Nunito",
//                                     ),
//                                   ),
//                                   Text(
//                                     " (+ ¥100)",
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(
//                                       color: colorSecondary,
//                                       letterSpacing: 1,
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w800,
//                                       fontFamily: "Nunito",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _spinkitLoading(BuildContext context) {
//     return Container(
//       width: SizeConfig.getWidth(context),
//       height: SizeConfig.getHeight(context),
//       color: Colors.white,
//       child: SpinKitThreeBounce(
//         color: colorBlueGaijin,
//         size: 20.0,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<DetailProductBloc>(
//       create: (context) {
        

//           void _pickImageDialog() {
//             showGeneralDialog(
//                 context: context,
//                 barrierDismissible: true,
//                 transitionDuration: Duration(milliseconds: 500),
//                 barrierLabel: MaterialLocalizations.of(context).dialogLabel,
//                 barrierColor: Colors.black.withOpacity(0.5),
//                 pageBuilder: (context, _, __) {
//                   return Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: 170.0,
//                           decoration: BoxDecoration(color: Color(0xFF2196F3)),
//                           child: Card(
//                             elevation: 0,
//                             color: Color(0xFF2196F3),
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(height: 20.0),
//                                 Container(
//                                   height: 25.0,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.close,
//                                           size: 24.0,
//                                           color: Colors.white,
//                                         ),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 ListTile(
//                                     title: Center(
//                                         child: Text(
//                                       'Pick From Camera',
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                                     onTap: () async {
//                                       final PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
//                                       if (pickedFile != null) {
//                                         _listImageFiles.add(File(pickedFile.path));
//                                       }
//                                       Navigator.pop(context);
//                                     }),
//                                 ListTile(
//                                     title: Center(
//                                         child: Text(
//                                       'Pick From Gallery',
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                                     onTap: () async {
//                                       final PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
//                                       if (pickedFile != null) {
//                                         _listImageFiles.add(File(pickedFile.path));
//                                       }
//                                       image.Image _image = image.decodeImage(_listImageFiles[0].readAsBytesSync());
//                                       image.Image _thumbnail = image.copyResizeCropSquare(_image, 50);
//                                       _image = image.copyResizeCropSquare(_image, 800);
//                                       Directory tempDir = await getTemporaryDirectory();
//                                       String tempPath = '${tempDir.path}/temp_${_randomString(9)}.png';
//                                       if (pickedFile != null) {
//                                         _listImageFiles[0] = File(tempPath)..writeAsBytesSync(image.encodePng(_thumbnail));
//                                       }
//                                       _listImageBase64.add(base64Encode(await _listImageFiles[0].readAsBytes()));
//                                       printWrapped(_listImageBase64[0]);
//                                       Navigator.of(context).pop(context);
//                                     }),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 transitionBuilder: (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: CurvedAnimation(
//                       parent: animation,
//                       curve: Curves.easeOut,
//                     ).drive(Tween<Offset>(
//                       begin: Offset(0, -1.0),
//                       end: Offset.zero,
//                     )),
//                     child: child,
//                   );
//                 });
//           }
//         return DetailProductBloc()
//           ..add(
//             PermissionEvent(
//               id: productId,
//               androidFusedLocation: androidFusedLocation,
//             ),
//           );
//         // return DetailProductBloc()..add(GetApiDetailProductEvent(id: productId));
//       },
//       child: BlocConsumer<DetailProductBloc, DetailProductState>(
//         listener: (context, state) {
//           if (state is DetailProductPermissionResponse) {
//             // if(state.geolocationStatus == GeolocationStatus.granted){
//             //   DetailProductBloc()..add(GetApiDetailProductEvent(id: productId));
//             // }else{
//             //   print("Should Request perrmission!");
//             // }
//           }
//         },
//         builder: (context, state) {
//           final stateCarousel = state.carouselPosition;

//           CarouselSlider getFullScreenCarousel(BuildContext mediaContext, List<CarouselModel> listItem) {
//             return CarouselSlider.builder(
//               autoPlay: false,
//               reverse: false,
//               enableInfiniteScroll: false,
//               viewportFraction: 1.0,
//               aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
//               scrollDirection: Axis.horizontal,
//               initialPage: stateCarousel,
//               onPageChanged: (index) {
//                 BlocProvider.of<DetailProductBloc>(context).add(CarouselEvent(position: index));
//               },
//               itemCount: listItem.length,
//               itemBuilder: (BuildContext context, int itemIndex) => Container(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(0.0)),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AddProductFullScreenCarouselPage(
//                                   listItem: listItem,
//                                   carouselPosition: stateCarousel,
//                                 )),
//                       );
//                     },
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.network(
//                           listItem.elementAt(itemIndex).imageUrl,
//                           fit: BoxFit.cover,
//                           width: 1000.0,
//                         ),
//                         Container(
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                           colors: [
//                             Colors.black45,
//                             Colors.transparent,
//                           ],
//                           stops: [0.0, 0.5],
//                           begin: Alignment.topCenter,
//                           end: Alignment.center,
//                           tileMode: TileMode.mirror,
//                         ))),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }

//           List<T> mapingCarousel<T>(List list, Function handler) {
//             List<T> result = [];
//             for (var i = 0; i < list.length; i++) {
//               result.add(handler(i, list[i]));
//             }
//             return result;
//           }

//           Widget _buildCarouselData(BuildContext context, List<CarouselModel> listItem) {
//             return Container(
//               color: Colors.white10,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   Positioned.fill(child: getFullScreenCarousel(context, listItem)),
//                   Positioned(
//                     left: 0.0,
//                     right: 0.0,
//                     bottom: 20.0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: mapingCarousel<Widget>(
//                         listItem,
//                         (index, url) {
//                           return AnimatedContainer(
//                             duration: Duration(milliseconds: 150),
//                             width: stateCarousel == index ? 30.0 : 8.0,
//                             height: stateCarousel == index ? 8.0 : 8.0,
//                             margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                             decoration: BoxDecoration(
//                               color: stateCarousel == index ? colorSecondary : Colors.white70,
//                               borderRadius: stateCarousel == index ? BorderRadius.all(Radius.circular(4.0)) : BorderRadius.all(Radius.circular(20)),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }

//           Widget _buildCarouselBaner(GlobalResponse response) {
//             List<CarouselModel> listItem = [];
//             List<ImagesResponse> listBanner = response.data.item.images;

//             for (var i = 0; i < listBanner.length; i++) {
//               listItem.add(CarouselModel("_title", "_content", listBanner[i].imgUrl, 'action'));
//             }

//             return _buildCarouselData(context, listItem);
//           }

//           void _removeImageDialog() {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return Dialog(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//                     child: Container(
//                       height: 180.0,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07, top: 20.0, bottom: 5.0),
//                             child: Text(
//                               'Remove Image',
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07, top: 10.0, bottom: 15.0),
//                             child: Text(
//                               'Are you sure you want to remove the image?',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                               ),
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Center(
//                                 child: SizedBox(
//                                   width: 117.0,
//                                   height: 41.0,
//                                   child: RaisedButton(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       // side: BorderSide(color: Colors.red)
//                                     ),
//                                     color: Color(0xFFE8E8E8),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text(
//                                       "Cancel",
//                                       style: TextStyle(color: Color(0xFF2196F3), fontSize: 14),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10.0,
//                               ),
//                               Center(
//                                 child: SizedBox(
//                                   width: 117.0,
//                                   height: 41.0,
//                                   child: RaisedButton(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       // side: BorderSide(color: Color(0XFF2B9FDC))
//                                     ),
//                                     color: Color(0xFFDE0000),
//                                     onPressed: () {
//                                       // _imageFile = null;
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text('Remove', style: TextStyle(color: Colors.white, fontSize: 14)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           }

//           Widget _buildImageInput() {
//             bool hasImage = false;
//             if (_listImageFiles.length > 0) hasImage = true;
//             if (hasImage) {
//               return Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 20.0, bottom: 38.0),
//                   child: Stack(
//                     children: <Widget>[
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Container(
//                             decoration: BoxDecoration(color: Color(0xFFC4C4C4), borderRadius: BorderRadius.circular(8.0)),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: Image(
//                                 // width: 106.0,
//                                 // height: 97.0,
//                                 image: FileImage(_listImageFiles[0]),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 106.0),
//                           child: Container(
//                             width: 25.0,
//                             height: 25.0,
//                             decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//                             child: Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(50.0),
//                                 onTap: () {
//                                   _removeImageDialog();
//                                 },
//                                 child: Icon(
//                                   Icons.close,
//                                   size: 18.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   // CachedNetworkImageProvider
//                 ),
//               );
//             }
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 26.0, bottom: 38.0),
//                 child: Container(
//                   width: 104.0,
//                   height: 96.0,
//                   decoration: BoxDecoration(color: Color(0xFFC4C4C4), borderRadius: BorderRadius.circular(8.0)),
//                   child: Material(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: InkWell(
//                           splashColor: Colors.white,
//                           borderRadius: BorderRadius.circular(8.0),
//                           onTap: null,
//                           child: Icon(
//                             Icons.add_a_photo,
//                             size: 40.0,
//                           ))),
//                 ),
//               ),
//             );
//           }

//           Widget _buildItemNameInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Item Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _itemNameController,
//                     decoration: InputDecoration(
//                       hintText: 'Type item\'s name',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildBrandNameInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Brand Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _brandNameController,
//                     decoration: InputDecoration(
//                       hintText: 'What is the brand of this item?',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildItemConditionInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Item Condition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _itemConditionController,
//                     decoration: InputDecoration(
//                       hintText: 'e.g. still functioning properly',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildYearsOwnedInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Text('Year\'s Owned', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 ListTile(
//                   title: const Text('Less than a year'),
//                   leading: Radio(
//                     value: 'Less than a year',
//                     groupValue: _yearsOwned,
//                     onChanged: (value) {
//                       _yearsOwned = value;
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text('1 - 2 years'),
//                   leading: Radio(
//                     value: '1 - 2 years',
//                     groupValue: _yearsOwned,
//                     onChanged: (value) {
//                       _yearsOwned = value;
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text('2 - 4 years'),
//                   leading: Radio(
//                     value: '2 - 4 years',
//                     groupValue: _yearsOwned,
//                     onChanged: (value) {
//                       _yearsOwned = value;
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text('More than 5 years'),
//                   leading: Radio(
//                     value: 'More than 5 years',
//                     groupValue: _yearsOwned,
//                     onChanged: (value) {
//                       _yearsOwned = value;
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildModelNameInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Model Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _modelNameController,
//                     decoration: InputDecoration(
//                       hintText: 'What is the model name of your item?',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildDescriptionInput() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       hintText: 'Fill your item\'s description',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           Widget _buildSetYourPricingButton() {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: FlatButton(
//                 color: Color(0xFF0F6EFF),
//                 onPressed: () {
//                   _addProductParam.product.name = _itemNameController.text;
//                   _addProductParam.productDetail.brand = _brandNameController.text;
//                   _addProductParam.productDetail.condition = _itemConditionController.text;
//                   _addProductParam.productDetail.modelName = _modelNameController.text;
//                   _addProductParam.product.description = _descriptionController.text;
//                   _addProductParam.productDetail.yearsOwned = _yearsOwned;
//                   for (int i = 0; i < _listImageBase64.length; i++) {
//                     _addProductParam.productImages.add(ProductImage(
//                       imageData: _listImageBase64[i],
//                       thumbData: _listThumbnailBase64[i],
//                     ));
//                   }
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct4thPage(addProductParam: _addProductParam)));
//                 },
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'Set your pricing  ',
//                         style: TextStyle(color: Colors.white, fontSize: 20.0),
//                       ),
//                       Icon(Icons.arrow_forward_ios, color: Colors.white),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }

//           Widget _buildDetailProduct(GlobalResponse response) {
//             ItemResponse detailItem = response.data.item;
//             String productId = detailItem.id;
//             String productName = "${detailItem.name}";
//             String productDescription = "${detailItem.description}";
//             String mainAddress = "Unknown Location";
//             String detailAddress = "Unknown Location";

//             if (state.placemarks[0].name != "unknown_location") {
//               mainAddress = "${state.placemarks[0].name}, ${state.placemarks[0].locality}";
//               detailAddress =
//                   "${state.placemarks[0].subLocality}, ${state.placemarks[0].administrativeArea}, ${state.placemarks[0].subAdministrativeArea} ${state.placemarks[0].postalCode}, ${state.placemarks[0].country}";
//             }
//             double latitude = detailItem.location.latitude;
//             double longitude = detailItem.location.longitude;

//             // Membuat marker
//             Set<Marker> _markers = HashSet<Marker>();

//             // void _onMapCreated(GoogleMapController controller) {
//             //   setState(() {
//             //     _markers.add(
//             //       Marker(
//             //         markerId: MarkerId(productId),
//             //         position: LatLng(latitude, longitude),
//             //         infoWindow:
//             //             InfoWindow(title: productName, snippet: productName),
//             //       ),
//             //     );
//             //   });
//             // }

//             return SliverPadding(
//               padding: EdgeInsets.all(16.0),
//               sliver: SliverToBoxAdapter(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     _buildItemNameInput(),
//                     _buildBrandNameInput(),
//                     _buildItemConditionInput(),
//                     _buildYearsOwnedInput(),
//                     _buildModelNameInput(),
//                     _buildDescriptionInput(),
//                     _buildSetYourPricingButton(),
//                   ],
//                 ),
//               ),
//             );
//           }

//           Widget _buildErrorBody(String message) {
//             return Container(
//               width: SizeConfig.getWidth(context),
//               height: SizeConfig.getHeight(context),
//               color: Colors.white,
//               child: Center(
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     height: 1.4,
//                     color: Colors.black54,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 11.0,
//                   ),
//                 ),
//               ),
//             );
//           }

//           Widget _buildBody(GlobalResponse response) {
//             String sellerUserId = response.data.seller.id;
//             String productPrice = "¥ ${response.data.item.price.toString()}";
//             String sellerName = response.data.seller.firstName + " " + response.data.seller.lastName;
//             String goldCoin = " " + response.data.seller.goldCoin.toString() + " gold";
//             String silverCoin = " " + response.data.seller.silverCoin.toString() + " silver";
//             String avatarSeller = response.data.seller.avatarUrl;
//             // String avatarSeller = "https://storage.googleapis.com/rails-2gaijin-storage/uploads/user/avatar/5da95727697d19f3f01f62b7/15744692455443238239852557782291.jpg";
//             // double latitude = response.data.item.location.latitude;
//             // double longitude = response.data.item.location.longitude;

//             // _getPlacemarkAddress(latitude, longitude);
//             String administrativeArea = "Unknown Location";
//             if (state.placemarks[0].name != "unknown_location") {
//               administrativeArea = state.placemarks[0].administrativeArea;
//             }

//             return Scaffold(
//               body: CustomScrollView(
//                 physics: BouncingScrollPhysics(),
//                 // physics: const AlwaysScrollableScrollPhysics(),
//                 slivers: <Widget>[
//                   // Header AppBar
//                   SliverPersistentHeader(
//                     pinned: true,
//                     floating: false,
//                     delegate: CustomSliverAppBar(
//                       maxHeight: 300,
//                       minHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
//                       carousel: _buildCarouselBaner(response),
//                       response: response,
//                     ),
//                   ),
//                   _buildDetailProduct(response),
//                 ],
//               ),
//             );
//           }

//           if (state is DetailProductInitial) {
//             return _spinkitLoading(context);
//           } else if (state is DetailProductPermissionResponse) {
//             if (state.geolocationStatus == GeolocationStatus.denied) {
//               return Container(
//                 width: SizeConfig.getWidth(context),
//                 height: SizeConfig.getHeight(context),
//                 color: Colors.white,
//                 padding: EdgeInsets.all(16.0),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Access location needed!',
//                         maxLines: 2,
//                         style: TextStyle(
//                           height: 1.4,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                       Text(
//                         'Allow access to the location services for this App using the device settings..',
//                         maxLines: 2,
//                         style: TextStyle(
//                           height: 1.4,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 11.0,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       ButtonTheme(
//                         minWidth: 180,
//                         child: RaisedButton(
//                           elevation: 5.0,
//                           onPressed: () {
//                             print("Refresh Page Button Pressed");

//                             DetailProductBloc()
//                               ..add(
//                                 PermissionEvent(
//                                   id: productId,
//                                   androidFusedLocation: androidFusedLocation,
//                                 ),
//                               );
//                           },
//                           padding: const EdgeInsets.all(10.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           color: colorSoftDark,
//                           child: Text(
//                             'Refresh Page',
//                             style: TextStyle(
//                               color: colorPrimary,
//                               letterSpacing: 1,
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           } else if (state is DetailProductResponse) {
//             if (state.response != null) {
//               if (state.response.status == "Success") {
//                 return _buildBody(state.response);
//               } else {
//                 return _buildErrorBody("Error => ${state.response.message}");
//               }
//             }
//           } else if (state is DetailProductError) {
//             print("Error => ${state.message}");
//             return _buildErrorBody("Error => ${state.message}");
//           }
//           return _spinkitLoading(context);
//         },
//       ),
//     );
//     // return FutureBuilder<GeolocationStatus>(
//     //   future: Geolocator().checkGeolocationPermissionStatus(),
//     //   builder:
//     //       (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
//     //     if (!snapshot.hasData) {
//     //       return _spinkitLoading(context);
//     //     }

//     //     if (snapshot.data == GeolocationStatus.denied) {
//     //       return Container(
//     //         width: SizeConfig.getWidth(context),
//     //         height: SizeConfig.getHeight(context),
//     //         color: Colors.white,
//     //         child: PlaceholderWidget('Access to location needed!',
//     //             'Allow access to the location services for this App using the device settings..'),
//     //       );
//     //     }
//     //   },
//     // );
//   }
// }

// class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
//   final GlobalResponse response;
//   final double minHeight;
//   final double maxHeight;
//   final Widget carousel;

//   CustomSliverAppBar({@required this.minHeight, @required this.maxHeight, @required this.response, @required this.carousel});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Stack(
//       fit: StackFit.expand,
//       overflow: Overflow.visible,
//       children: [
//         Container(
//           color: colorDarkBackground,
//           child: carousel,
//         ),
//         Visibility(
//           visible: (shrinkOffset / maxHeight) > 0.5 ? true : false,
//           child: Opacity(
//             opacity: shrinkOffset / maxHeight,
//             child: Container(
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Center(
//           child: Opacity(
//             opacity: shrinkOffset / maxHeight,
//             child: Text(
//               "Tell us the detail of your item",
//               style: TextStyle(
//                 color: colorDarkBackground,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 0.0,
//           right: 0.0,
//           bottom: -2.0,
//           child: Container(
//             height: 20,
//             width: MediaQuery.of(context).size.width / 2,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(30.0),
//                 topRight: const Radius.circular(30.0),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0.0,
//           left: 10.0,
//           child: SafeArea(
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: (shrinkOffset / maxHeight) > 0.5 ? colorDarkBackground : Colors.white),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0.0,
//           right: 10.0,
//           child: SafeArea(
//             child: IconButton(
//               icon: Icon(Icons.add_photo_alternate, color: (shrinkOffset / maxHeight) > 0.5 ? colorDarkBackground : Colors.white),
//               onPressed: () {
//                 // _pickImageDialog();
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   double get maxExtent => max(maxHeight, minHeight);

//   @override
//   double get minExtent => minHeight;

//   @override
//   bool shouldRebuild(CustomSliverAppBar oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || carousel != oldDelegate.carousel;
//   }
// }

// class GenerateProductItem extends StatelessWidget {
//   final CatalogModel _model;

//   GenerateProductItem(this._model);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Card(
//             child: GestureDetector(
//       onTap: () {
//         print("Detail Clicked with ID => ${_model.id}");

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AddProduct3rdPage(
//               productId: _model.id,
//               androidFusedLocation: true,
//             ),
//           ),
//         );
//       },
//       child: Stack(
//         children: <Widget>[
//           // Content Images and Description Product
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               _model.imageUrl == null
//                   ? Container(
//                       height: 180.0,
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent,
//                         borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                         shape: BoxShape.rectangle,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Icon(
//                             EvaIcons.filmOutline,
//                             color: Colors.white,
//                             size: 60.0,
//                           )
//                         ],
//                       ),
//                     )
//                   : Container(
//                       height: 180.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                         shape: BoxShape.rectangle,
//                         image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_model.imageUrl)),
//                       )),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       width: double.infinity,
//                       child: Text(
//                         '${_model.title}',
//                         maxLines: 2,
//                         style: TextStyle(height: 1.4, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 11.0),
//                       ),
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 5.0,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       child: Text(
//                         '¥ ${_model.price}',
//                         maxLines: 1,
//                         style: TextStyle(height: 1.4, color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 11.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//             ],
//           ),
//           // Button icon favorite
//           Positioned(
//             top: 8,
//             right: 8,
//             child: CircleButton(
//               onTap: null,
//               iconData: Icons.favorite,
//               iconSize: 20,
//               color: _model.isWishlist ? Colors.pink : Colors.grey,
//               backgrounColor: Colors.white,
//               padding: 4,
//             ),
//           ),
//         ],
//       ),
//     )));
//   }
// }

// class BottomShapeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0.0, size.height);

//     Offset firstEndPoint = Offset(10, 20);
//     Offset firstControlPoint = Offset(5, 25);

//     path.lineTo(firstEndPoint.dx, firstEndPoint.dy);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0.0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class CreateProductItemDetail extends StatelessWidget {
//   final ItemsResponse _itemsResponse;

//   CreateProductItemDetail(this._itemsResponse);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 150,
//         child: Card(
//             child: GestureDetector(
//           onTap: () {
//             print("Detail Clicked with ID => ${_itemsResponse.id}");

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddProduct3rdPage(
//                   productId: _itemsResponse.id,
//                   androidFusedLocation: true,
//                 ),
//               ),
//             );
//           },
//           child: Stack(
//             children: <Widget>[
//               // Content Images and Description Product
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   _itemsResponse.imgUrl == null
//                       ? Container(
//                           height: 130.0,
//                           decoration: BoxDecoration(
//                             color: Colors.blueAccent,
//                             borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                             shape: BoxShape.rectangle,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 EvaIcons.filmOutline,
//                                 color: Colors.white,
//                                 size: 60.0,
//                               )
//                             ],
//                           ),
//                         )
//                       : Container(
//                           height: 130.0,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                             shape: BoxShape.rectangle,
//                             image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_itemsResponse.imgUrl)),
//                           )),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           width: double.infinity,
//                           child: Text(
//                             '${_itemsResponse.name}',
//                             maxLines: 2,
//                             style: TextStyle(height: 1.4, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 11.0),
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 5.0,
//                         ),
//                         Container(
//                           width: double.infinity,
//                           child: Text(
//                             '¥ ${_itemsResponse.price}',
//                             maxLines: 1,
//                             style: TextStyle(height: 1.4, color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 11.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                 ],
//               ),
//               // Button icon favorite
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: CircleButton(
//                   onTap: null,
//                   iconData: Icons.favorite,
//                   iconSize: 20,
//                   color: Colors.grey,
//                   backgrounColor: Colors.white,
//                   padding: 4,
//                 ),
//               ),
//             ],
//           ),
//         )));
//   }
// }
