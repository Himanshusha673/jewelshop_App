import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/product.dart';
import 'package:jewelshop/Provider/products_provider.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const routeName = '/editscreen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final price_focusNode = FocusNode();
  final description_focusNode = FocusNode();
  final _imageURL_focusNode = FocusNode();
  final _imageURlConatroller = TextEditingController();
  var _editProduct =
      Product(id: null, title: '', description: '', imageUrl: '', price: 0);
  final _form = GlobalKey<FormState>();
  var isLoading = false;

  // we need to dispose the focusnode because it will stick
  // to the memory when state is cleared r we move on the next screen

  var isInit = true;
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };

  @override
  void initState() {
    _imageURL_focusNode.addListener(_Update_imaegURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments == null
          ? "NULL"
          : ModalRoute.of(context)!.settings.arguments.toString();

      if (productId != 'NULL') {
        _editProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        initValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          //'imageURL': _editProduct.imageUrl, we cant create
          //initial vlaue of textformfield which has controller so we need to declare insaide the imagecontroller
          'imageUrl': '',
        };
        _imageURlConatroller.text = _editProduct.imageUrl;
      }
    }

    isInit = false; // used for only beacsue w dont want to
    // execute code only by once because didchangedependency runs multipletime when screen renders
    super.didChangeDependencies();
  }

  void _Update_imaegURL() {
    if (!_imageURL_focusNode.hasFocus) {
      if ((!_imageURlConatroller.text.startsWith('http')) &&
              (!_imageURlConatroller.text.startsWith('https')) ||
          (!_imageURlConatroller.text.endsWith('.png')) &&
              !_imageURlConatroller.text.endsWith('.jpg') &&
              !_imageURlConatroller.text.endsWith('.jpeg')) {
        return;
      }

      setState(() {});
      //if we not used focus by any button on keyboard after
      //filling url in urltextformfeild and if we perform any action then it callas setstaet and ui changes

    }
  } // this method we used because if we want to show image after pasting
  //the url into url textform field then not even clicking on keboard action
  //then we simply pass this fxn using a listener

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });

    if (_editProduct.id != null) {
      //if it is null then we need to add as a new product and if not null means having some values then we need to update
      Provider.of<ProductProvider>(context, listen: false)
          .upDateProducts(_editProduct.id.toString(), _editProduct);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addproducts(_editProduct)
          .catchError((onError) {
        return showDialog<Null>(
            // here we use the return keyword because we wont go to .then block if there occurs an error
            // because .then block continuosly occurs whenever our datat is not added to server and loading
            //indicator continuously moves so after occurs any error we have to return and not goes to then block
            // note because they all return future

            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Oops! There is an error'),
                  content: Text('Somethnig went wrong.'),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'),
                    ),
                  ],
                ));
      }).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageURL_focusNode.removeListener(_Update_imaegURL);
    price_focusNode.dispose();
    description_focusNode.dispose();
    _imageURlConatroller.dispose();
    _imageURL_focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Details here'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.yellowAccent,
            ))
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: ListView(children: [
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(
                          label: Text(
                        'Title',
                      )),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Provide a Title";
                        }

                        return null;
                      },

                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(price_focusNode);
                      },
                      //this will tells that on pressed insie the keboardtextinput connection what would be happens

                      onSaved: (value) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            isFavourite: _editProduct.isFavourite,
                            title: value.toString(),
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            price: _editProduct.price);
                      },
                    ),
                    TextFormField(
                        initialValue: initValues['price'],
                        decoration: InputDecoration(label: Text('Price')),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: price_focusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(description_focusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter a valid Price ";
                          }
                          if (double.parse(value) <= 0) {
                            return "Price Shouldn't less than or 0 ";
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please Enetr a valid Number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              isFavourite: _editProduct.isFavourite,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              imageUrl: _editProduct.imageUrl,
                              price: double.parse(value!));
                        }),
                    TextFormField(
                        initialValue: initValues['description'],
                        decoration: InputDecoration(label: Text('Description')),
                        textInputAction: TextInputAction.newline,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: description_focusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a Description';
                          }
                          if (value.length < 10) {
                            return "Your Description Should be atleast character ";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              isFavourite: _editProduct.isFavourite,
                              title: _editProduct.title,
                              description: value.toString(),
                              imageUrl: _editProduct.imageUrl,
                              price: _editProduct.price);
                        }),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 1,
                                )),
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 10, right: 8),
                            child: _imageURlConatroller.text.isEmpty
                                ? Center(
                                    child: Text(
                                      'Enter a URL',
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : FittedBox(
                                    child: Image.network(
                                        _imageURlConatroller.text),
                                    fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text("ImageURL")),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                controller: _imageURlConatroller,
                                focusNode: _imageURL_focusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter a ImaegURl First';
                                  }
                                  if ((!value.startsWith('http')) &&
                                      (!value.startsWith('https'))) {
                                    return ' Thid Is not a valid ImageURL';
                                  }
                                  if (!value.endsWith('.png') &&
                                      !value.endsWith('.jpg') &&
                                      !value.endsWith('.jpeg')) {
                                    return ' Not a Image URL';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                onSaved: (value) {
                                  _editProduct = Product(
                                      id: _editProduct.id,
                                      isFavourite: _editProduct.isFavourite,
                                      title: _editProduct.title,
                                      description: _editProduct.description,
                                      imageUrl: value.toString(),
                                      price: _editProduct.price);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
    );
  }
}
