import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/screens/add_product/add_product_4th_page.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:image_cropper/image_cropper.dart';

class AddProduct3rdPage extends StatefulWidget {
  final bool isEditProduct;
  final AddProductParam addProductParam;
  final EditProductParam editProductParam;

  AddProduct3rdPage({
    Key key,
    @required this.isEditProduct,
    this.addProductParam,
    this.editProductParam,
  }) : super(key: key);

  @override
  _AddProduct3rdPageState createState() => _AddProduct3rdPageState();
}

class _AddProduct3rdPageState extends State<AddProduct3rdPage> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _itemConditionController = TextEditingController();
  final TextEditingController _modelNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<File> _listImageFiles = [];
  List<String> _listImageBase64 = [];
  List<String> _listThumbnailBase64 = [];

  AddProductParam _addProductParam;
  EditProductParam _editProductParam;
  String _yearsOwned;

  @override
  void initState() {
    super.initState();
    _yearsOwned = 'Less than a year';
    _addProductParam = widget.addProductParam;
    _editProductParam = widget.editProductParam;
    if (widget.isEditProduct) {
      _itemNameController.text = _editProductParam.product.name;
      _brandNameController.text = _editProductParam.productDetail.brand;
      _itemConditionController.text = _editProductParam.productDetail.condition;
      _modelNameController.text = _editProductParam.productDetail.modelName;
      _descriptionController.text = _editProductParam.product.description;

      if (_editProductParam.productDetail.yearsOwned.isNotEmpty) {
        _yearsOwned = _editProductParam.productDetail.yearsOwned;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _itemNameController.dispose();
    _brandNameController.dispose();
    _itemConditionController.dispose();
    _modelNameController.dispose();
    _descriptionController.dispose();
  }

  String dateTimeToTimeString(DateTime dateTime) => dateTime.toString().split(' ')[1].substring(0, 5);

  @override
  Widget build(BuildContext context) {
    Widget _buildAppBar() {
      return AppBar(
        title: Text('Tell us the detail of your item', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorGreyGaijin),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Future<void> _processImage(PickedFile pickedFile) async {
      if (pickedFile == null) return;
      final File file = File(pickedFile.path);
      File imageFile = await ImageCropper.cropImage(
          sourcePath: file.path,
          maxHeight: 800,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit image',
            toolbarColor: colorOrangeGaijin,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (imageFile == null) return;
      File thumbnailFile = await FlutterNativeImage.compressImage(imageFile.path, quality: 80, targetWidth: 300, targetHeight: 300);
      setState(() {
        _listImageFiles.add(imageFile);
      });
      _listImageBase64.add(base64.encode(imageFile.readAsBytesSync()));
      _listThumbnailBase64.add(base64.encode(thumbnailFile.readAsBytesSync()));
    }

    void _pickImageDialog() {
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 500),
          barrierLabel: MaterialLocalizations.of(context).dialogLabel,
          barrierColor: Colors.black.withOpacity(0.5),
          pageBuilder: (context, _, __) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170.0,
                    decoration: BoxDecoration(color: Color(0xFF2196F3)),
                    child: Card(
                      elevation: 0,
                      color: Color(0xFF2196F3),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Container(
                            height: 25.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          ListTile(
                              title: Center(
                                  child: Text(
                                'Pick From Camera',
                                style: TextStyle(color: Colors.white),
                              )),
                              onTap: () async {
                                final PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
                                await _processImage(pickedFile);
                                Navigator.pop(context);
                              }),
                          ListTile(
                              title: Center(
                                  child: Text(
                                'Pick From Gallery',
                                style: TextStyle(color: Colors.white),
                              )),
                              onTap: () async {
                                final PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                                await _processImage(pickedFile);
                                Navigator.of(context).pop(context);
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ).drive(Tween<Offset>(
                begin: Offset(0, -1.0),
                end: Offset.zero,
              )),
              child: child,
            );
          });
    }

    void _removeImageDialog(int index) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                height: 180.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07, top: 20.0, bottom: 5.0),
                      child: Text(
                        'Remove Image',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07, top: 10.0, bottom: 15.0),
                      child: Text(
                        'Are you sure you want to remove the image?',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            width: 117.0,
                            height: 41.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                // side: BorderSide(color: Colors.red)
                              ),
                              color: Color(0xFFE8E8E8),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Color(0xFF2196F3), fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Center(
                          child: SizedBox(
                            width: 117.0,
                            height: 41.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                // side: BorderSide(color: Color(0XFF2B9FDC))
                              ),
                              color: Color(0xFFDE0000),
                              onPressed: () {
                                setState(() {
                                  _listImageFiles.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Remove', style: TextStyle(color: Colors.white, fontSize: 14)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    Widget _buildImageTile(int index) {
      return Center(
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  width: 104.0,
                  height: 96.0,
                  image: FileImage(_listImageFiles[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      _removeImageDialog(index);
                    },
                    child: Icon(
                      Icons.close,
                      size: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _buildAddImage() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 104.0,
            height: 96.0,
            decoration: BoxDecoration(color: Color(0xFFC4C4C4), borderRadius: BorderRadius.circular(8.0)),
            child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      _pickImageDialog();
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      size: 40.0,
                    ))),
          ),
        ),
      );
    }

    Widget _buildImageInput() {
      bool hasImage = false;
      if (_listImageFiles.length > 0) hasImage = true;
      if (hasImage) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 112.5), // **THIS is the important part**
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _listImageFiles.length + 1,
            itemBuilder: (context, index) {
              if (index == _listImageFiles.length) {
                return _buildAddImage();
              }
              return _buildImageTile(index);
            },
          ),
        );
      }
      return _buildAddImage();
    }

    Widget _buildInputTitle(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
      );
    }

    Widget _buildItemNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInputTitle('Item Name'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: 'Type item\'s name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildBrandNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Brand Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _brandNameController,
              decoration: InputDecoration(
                hintText: 'What is the brand of this item?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildItemConditionInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Item Condition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _itemConditionController,
              decoration: InputDecoration(
                hintText: 'e.g. still functioning properly',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildRadioTile(String value) {
      return ListTile(
        title: Text(value),
        leading: Radio(
          value: value,
          activeColor: colorOrangeGaijin,
          groupValue: _yearsOwned,
          onChanged: (value) {
            setState(() {
              _yearsOwned = value;
            });
          },
        ),
      );
    }

    Widget _buildYearsOwnedInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Year\'s Owned', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          _buildRadioTile('Less than a year'),
          _buildRadioTile('1 - 2 years'),
          _buildRadioTile('2 - 4 years'),
          _buildRadioTile('More than 5 years'),
        ],
      );
    }

    Widget _buildModelNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Model Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _modelNameController,
              decoration: InputDecoration(
                hintText: 'What is the model name of your item?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildDescriptionInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Fill your item\'s description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildSetYourPricingButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FlatButton(
          color: colorOrangeGaijin,
          onPressed: () {
            if (widget.isEditProduct) {
              _editProductParam.product.name = _itemNameController.text;
              _editProductParam.productDetail.brand = _brandNameController.text;
              _editProductParam.productDetail.condition = _itemConditionController.text;
              _editProductParam.productDetail.modelName = _modelNameController.text;
              _editProductParam.product.description = _descriptionController.text;
              _editProductParam.productDetail.yearsOwned = _yearsOwned;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProduct4thPage(
                            isEditProduct: widget.isEditProduct,
                            editProductParam: _editProductParam,
                          )));
            } else {
              _addProductParam.product.name = _itemNameController.text;
              _addProductParam.productDetail.brand = _brandNameController.text;
              _addProductParam.productDetail.condition = _itemConditionController.text;
              _addProductParam.productDetail.modelName = _modelNameController.text;
              _addProductParam.product.description = _descriptionController.text;
              _addProductParam.productDetail.yearsOwned = _yearsOwned;
              for (int i = 0; i < _listImageBase64.length; i++) {
                _addProductParam.productImages.add(ProductImage(
                  imageData: _listImageBase64[i],
                  thumbData: _listThumbnailBase64[i],
                ));
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProduct4thPage(
                            isEditProduct: widget.isEditProduct,
                            addProductParam: _addProductParam,
                          )));
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Set your pricing  ',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildBody() {
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                widget.isEditProduct ? Container() : _buildImageInput(),
                _buildItemNameInput(),
                _buildBrandNameInput(),
                _buildItemConditionInput(),
                _buildYearsOwnedInput(),
                _buildModelNameInput(),
                _buildDescriptionInput(),
                _buildSetYourPricingButton(),
              ],
            ),
          ),
        ],
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }
}
