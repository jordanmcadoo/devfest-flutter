//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//        statusBarIconBrightness: Brightness.light
//    ));
//    return MaterialApp(
//      title: 'Flutter Demo',
//      color: Theme.CustomColors.greenBlue[500],
//      theme: Theme.CustomTheme,
//      home: ShrineHome(),
//    );
//  }
//}
//
//class Product {
//  const Product({
//    this.name,
//    this.description,
//    this.featureTitle,
//    this.featureDescription,
//    this.imageAsset,
//    this.imageAssetPackage,
//    this.categories,
//    this.price,
//    this.vendor
//  });
//
//  final String name;
//  final String description;
//  final String featureTitle;
//  final String featureDescription;
//  final String imageAsset;
//  final String imageAssetPackage;
//  final List<String> categories;
//  final double price;
//  final Vendor vendor;
//
//  String get tag => name; // Unique value for Heroes
//  String get priceString => '\$${price.floor()}';
//
//  bool isValid() {
//    return name != null &&
//        description != null &&
//        imageAsset != null &&
//        categories != null &&
//        categories.isNotEmpty &&
//        price != null &&
//        vendor.isValid();
//  }
//
//  @override
//  String toString() => 'Product($name)';
//}
//
//class Order {
//  Order({ @required this.product, this.quantity = 1, this.inCart = false })
//      : assert(product != null),
//        assert(quantity != null && quantity >= 0),
//        assert(inCart != null);
//
//  final Product product;
//  final int quantity;
//  final bool inCart;
//
//  Order copyWith({ Product product, int quantity, bool inCart }) {
//    return Order(
//        product: product ?? this.product,
//        quantity: quantity ?? this.quantity,
//        inCart: inCart ?? this.inCart
//    );
//  }
//
//  @override
//  bool operator ==(dynamic other) {
//    if (identical(this, other))
//      return true;
//    if (other.runtimeType != runtimeType)
//      return false;
//    final Order typedOther = other;
//    return product == typedOther.product &&
//        quantity == typedOther.quantity &&
//        inCart == typedOther.inCart;
//  }
//
//  @override
//  int get hashCode => hashValues(product, quantity, inCart);
//
//  @override
//  String toString() => 'Order($product, quantity=$quantity, inCart=$inCart)';
//}
//
//const double unitSize = kToolbarHeight;
//
//final List<Product> _products = List<Product>.from(allProducts());
//final Map<Product, Order> _shoppingCart = <Product, Order>{};
//
//const int _childrenPerBlock = 8;
//const int _rowsPerBlock = 5;
//
//int _minIndexInRow(int rowIndex) {
//  final int blockIndex = rowIndex ~/ _rowsPerBlock;
//  return const <int>[0, 2, 4, 6, 7][rowIndex % _rowsPerBlock] + blockIndex * _childrenPerBlock;
//}
//
//int _maxIndexInRow(int rowIndex) {
//  final int blockIndex = rowIndex ~/ _rowsPerBlock;
//  return const <int>[1, 3, 5, 6, 7][rowIndex % _rowsPerBlock] + blockIndex * _childrenPerBlock;
//}
//
//int _rowAtIndex(int index) {
//  final int blockCount = index ~/ _childrenPerBlock;
//  return const <int>[0, 0, 1, 1, 2, 2, 3, 4][index - blockCount * _childrenPerBlock] + blockCount * _rowsPerBlock;
//}
//
//int _columnAtIndex(int index) {
//  return const <int>[0, 1, 0, 1, 0, 1, 0, 0][index % _childrenPerBlock];
//}
//
//int _columnSpanAtIndex(int index) {
//  return const <int>[1, 1, 1, 1, 1, 1, 2, 2][index % _childrenPerBlock];
//}
//
//// The Shrine home page arranges the product cards into two columns. The card
//// on every 4th and 5th row spans two columns.
//class _ShrineGridLayout extends SliverGridLayout {
//  const _ShrineGridLayout({
//    @required this.rowStride,
//    @required this.columnStride,
//    @required this.tileHeight,
//    @required this.tileWidth,
//  });
//
//  final double rowStride;
//  final double columnStride;
//  final double tileHeight;
//  final double tileWidth;
//
//  @override
//  int getMinChildIndexForScrollOffset(double scrollOffset) {
//    return _minIndexInRow(scrollOffset ~/ rowStride);
//  }
//
//  @override
//  int getMaxChildIndexForScrollOffset(double scrollOffset) {
//    return _maxIndexInRow(scrollOffset ~/ rowStride);
//  }
//
//  @override
//  SliverGridGeometry getGeometryForChildIndex(int index) {
//    final int row = _rowAtIndex(index);
//    final int column = _columnAtIndex(index);
//    final int columnSpan = _columnSpanAtIndex(index);
//    return SliverGridGeometry(
//      scrollOffset: row * rowStride,
//      crossAxisOffset: column * columnStride,
//      mainAxisExtent: tileHeight,
//      crossAxisExtent: tileWidth + (columnSpan - 1) * columnStride,
//    );
//  }
//
//  @override
//  double computeMaxScrollOffset(int childCount) {
//    if (childCount == 0)
//      return 0.0;
//    final int rowCount = _rowAtIndex(childCount - 1) + 1;
//    final double rowSpacing = rowStride - tileHeight;
//    return rowStride * rowCount - rowSpacing;
//  }
//}
//
//class _ShrineGridDelegate extends SliverGridDelegate {
//  static const double _spacing = 8.0;
//
//  @override
//  SliverGridLayout getLayout(SliverConstraints constraints) {
//    final double tileWidth = (constraints.crossAxisExtent - _spacing) / 2.0;
//    const double tileHeight = 40.0 + 144.0 + 40.0;
//    return _ShrineGridLayout(
//      tileWidth: tileWidth,
//      tileHeight: tileHeight,
//      rowStride: tileHeight + _spacing,
//      columnStride: tileWidth + _spacing,
//    );
//  }
//
//  @override
//  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) => false;
//}
//
//// Displays the Vendor's name and avatar.
//class _VendorItem extends StatelessWidget {
//  const _VendorItem({ Key key, @required this.vendor })
//      : assert(vendor != null),
//        super(key: key);
//
//  final Vendor vendor;
//
//  @override
//  Widget build(BuildContext context) {
//    return SizedBox(
//      height: 24.0,
//      child: Row(
//        children: <Widget>[
//          SizedBox(
//            width: 24.0,
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(12.0),
//              child: Image.asset(
//                vendor.avatarAsset,
//                package: vendor.avatarAssetPackage,
//                fit: BoxFit.cover,
//              ),
//            ),
//          ),
//          const SizedBox(width: 8.0),
//          Expanded(
//            child: Text(vendor.name, style: Theme.vendorItemStyle),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//// Displays the product's price. If the product is in the shopping cart then the
//// background is highlighted.
//abstract class _PriceItem extends StatelessWidget {
//  const _PriceItem({ Key key, @required this.product })
//      : assert(product != null),
//        super(key: key);
//
//  final Product product;
//
//  Widget buildItem(BuildContext context, TextStyle style, EdgeInsets padding) {
//    BoxDecoration decoration;
//    if (_shoppingCart[product] != null)
//      decoration = BoxDecoration(color: Theme.priceHighlightColor);
//
//    return Container(
//      padding: padding,
//      decoration: decoration,
//      child: Text(product.priceString, style: style),
//    );
//  }
//}
//
//class _ProductPriceItem extends _PriceItem {
//  const _ProductPriceItem({ Key key, Product product }) : super(key: key, product: product);
//
//  @override
//  Widget build(BuildContext context) {
//    return buildItem(
//      context,
//      Theme.priceStyle,
//      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//    );
//  }
//}
//
//class _FeaturePriceItem extends _PriceItem {
//  const _FeaturePriceItem({ Key key, Product product }) : super(key: key, product: product);
//
//  @override
//  Widget build(BuildContext context) {
//    return buildItem(
//      context,
//      Theme.featurePriceStyle,
//      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//    );
//  }
//}
//
//class _HeadingLayout extends MultiChildLayoutDelegate {
//  _HeadingLayout();
//
//  static const String price = 'price';
//  static const String image = 'image';
//  static const String title = 'title';
//  static const String description = 'description';
//  static const String vendor = 'vendor';
//
//  @override
//  void performLayout(Size size) {
//    final Size priceSize = layoutChild(price, BoxConstraints.loose(size));
//    positionChild(price, Offset(size.width - priceSize.width, 0.0));
//
//    final double halfWidth = size.width / 2.0;
//    final double halfHeight = size.height / 2.0;
//    const double halfUnit = unitSize / 2.0;
//    const double margin = 16.0;
//
//    final Size imageSize = layoutChild(image, BoxConstraints.loose(size));
//    final double imageX = imageSize.width < halfWidth - halfUnit
//        ? halfWidth / 2.0 - imageSize.width / 2.0 - halfUnit
//        : halfWidth - imageSize.width;
//    positionChild(image, Offset(imageX, halfHeight - imageSize.height / 2.0));
//
//    final double maxTitleWidth = halfWidth + unitSize - margin;
//    final BoxConstraints titleBoxConstraints = BoxConstraints(maxWidth: maxTitleWidth);
//    final Size titleSize = layoutChild(title, titleBoxConstraints);
//    final double titleX = halfWidth - unitSize;
//    final double titleY = halfHeight - titleSize.height;
//    positionChild(title, Offset(titleX, titleY));
//
//    final Size descriptionSize = layoutChild(description, titleBoxConstraints);
//    final double descriptionY = titleY + titleSize.height + margin;
//    positionChild(description, Offset(titleX, descriptionY));
//
//    layoutChild(vendor, titleBoxConstraints);
//    final double vendorY = descriptionY + descriptionSize.height + margin;
//    positionChild(vendor, Offset(titleX, vendorY));
//  }
//
//  @override
//  bool shouldRelayout(_HeadingLayout oldDelegate) => false;
//}
//
//// A card that highlights the "featured" catalog item.
//class _Heading extends StatelessWidget {
//  _Heading({ Key key, @required this.product })
//      : assert(product != null),
//        assert(product.featureTitle != null),
//        assert(product.featureDescription != null),
//        super(key: key);
//
//  final Product product;
//
//  @override
//  Widget build(BuildContext context) {
//    final Size screenSize = MediaQuery.of(context).size;
//    return MergeSemantics(
//      child: SizedBox(
//        height: screenSize.width > screenSize.height
//            ? (screenSize.height - kToolbarHeight) * 0.85
//            : (screenSize.height - kToolbarHeight) * 0.70,
//        child: Container(
//          decoration: BoxDecoration(
//            color: Theme.cardBackgroundColor,
//            border: Border(bottom: BorderSide(color: Theme.dividerColor)),
//          ),
//          child: CustomMultiChildLayout(
//            delegate: _HeadingLayout(),
//            children: <Widget>[
//              LayoutId(
//                id: _HeadingLayout.price,
//                child: _FeaturePriceItem(product: product),
//              ),
//              LayoutId(
//                id: _HeadingLayout.image,
//                child: Image.asset(
//                  product.imageAsset,
//                  package: product.imageAssetPackage,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              LayoutId(
//                id: _HeadingLayout.title,
//                child: Text(product.featureTitle, style: Theme.featureTitleStyle),
//              ),
//              LayoutId(
//                id: _HeadingLayout.description,
//                child: Text(product.featureDescription, style: Theme.featureStyle),
//              ),
//              LayoutId(
//                id: _HeadingLayout.vendor,
//                child: _VendorItem(vendor: product.vendor),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//// A card that displays a product's image, price, and vendor. The _ProductItem
//// cards appear in a grid below the heading.
//class _ProductItem extends StatelessWidget {
//  const _ProductItem({ Key key, @required this.product, this.onPressed })
//      : assert(product != null),
//        super(key: key);
//
//  final Product product;
//  final VoidCallback onPressed;
//
//  @override
//  Widget build(BuildContext context) {
//    return MergeSemantics(
//      child: Card(
//        child: Stack(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                Align(
//                  alignment: Alignment.centerRight,
//                  child: _ProductPriceItem(product: product),
//                ),
//                Container(
//                  width: 144.0,
//                  height: 144.0,
//                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                  child: Hero(
//                    tag: product.tag,
//                    child: Image.asset(
//                      product.imageAsset,
//                      package: product.imageAssetPackage,
//                      fit: BoxFit.contain,
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                  child: _VendorItem(vendor: product.vendor),
//                ),
//              ],
//            ),
//            Material(
//              type: MaterialType.transparency,
//              child: InkWell(onTap: onPressed),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//// The Shrine app's home page. Displays the featured item above a grid
//// of the product items.
//class ShrineHome extends StatefulWidget {
//  @override
//  _ShrineHomeState createState() => _ShrineHomeState();
//}
//
//class _ShrineHomeState extends State<ShrineHome> {
//  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'Shrine Home');
//  static final _ShrineGridDelegate gridDelegate = _ShrineGridDelegate();
//
////  Future<void> _showOrderPage(Product product) async {
////    final Order order = _shoppingCart[product] ?? Order(product: product);
////    final Order completedOrder = await Navigator.push(context, ShrineOrderRoute(
////        order: order,
////        builder: (BuildContext context) {
////          return OrderPage(
////            order: order,
////            products: _products,
////            shoppingCart: _shoppingCart,
////          );
////        }
////    ));
////    assert(completedOrder.product != null);
////    if (completedOrder.quantity == 0)
////      _shoppingCart.remove(completedOrder.product);
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    final Product featured = _products.firstWhere((Product product) => product.featureDescription != null);
//    return ShrinePage(
//      scaffoldKey: _scaffoldKey,
//      products: _products,
//      shoppingCart: _shoppingCart,
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverToBoxAdapter(child: _Heading(product: featured)),
//          SliverSafeArea(
//            top: false,
//            minimum: const EdgeInsets.all(16.0),
//            sliver: SliverGrid(
//              gridDelegate: gridDelegate,
//              delegate: SliverChildListDelegate(
//                _products.map<Widget>((Product product) {
//                  return _ProductItem(
//                    product: product,
//                    onPressed: () { },//_showOrderPage(product); },
//                  );
//                }).toList(),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class ShrinePage extends StatefulWidget {
//  const ShrinePage({
//    Key key,
//    @required this.scaffoldKey,
//    @required this.body,
//    this.floatingActionButton,
//    this.products,
//    this.shoppingCart
//  }) : assert(body != null),
//        assert(scaffoldKey != null),
//        super(key: key);
//
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final Widget body;
//  final Widget floatingActionButton;
//  final List<Product> products;
//  final Map<Product, Order> shoppingCart;
//
//  @override
//  ShrinePageState createState() => ShrinePageState();
//}
//
//enum ShrineAction {
//  sortByPrice,
//  sortByProduct,
//  emptyCart
//}
//
//class ShrinePageState extends State<ShrinePage> {
//  double _appBarElevation = 0.0;
//
//  bool _handleScrollNotification(ScrollNotification notification) {
//    final double elevation = notification.metrics.extentBefore <= 0.0 ? 0.0 : 1.0;
//    if (elevation != _appBarElevation) {
//      setState(() {
//        _appBarElevation = elevation;
//      });
//    }
//    return false;
//  }
//
//  void _showShoppingCart() {
//    showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
//      if (widget.shoppingCart.isEmpty) {
//        return const Padding(
//            padding: EdgeInsets.all(24.0),
//            child: Text('The shopping cart is empty')
//        );
//      }
//      return ListView(
//        padding: kMaterialListPadding,
//        children: widget.shoppingCart.values.map((Order order) {
//          return ListTile(
//              title: Text(order.product.name),
//              leading: Text('${order.quantity}'),
//              subtitle: Text(order.product.vendor.name)
//          );
//        }).toList(),
//      );
//    });
//  }
//
//  void _sortByPrice() {
//    widget.products.sort((Product a, Product b) => a.price.compareTo(b.price));
//  }
//
//  void _sortByProduct() {
//    widget.products.sort((Product a, Product b) => a.name.compareTo(b.name));
//  }
//
//  void _emptyCart() {
//    widget.shoppingCart.clear();
//    widget.scaffoldKey.currentState.showSnackBar(const SnackBar(content: Text('Shopping cart is empty')));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        key: widget.scaffoldKey,
//        appBar: AppBar(
//            elevation: _appBarElevation,
//            backgroundColor: Theme.appBarBackgroundColor,
//            brightness: Brightness.light,
//            flexibleSpace: Container(
//                decoration: BoxDecoration(
//                    border: Border(
//                        bottom: BorderSide(color: Theme.dividerColor)
//                    )
//                )
//            ),
//            title: Text('SHRINE', style: Theme.appBarTitleStyle),
//            centerTitle: true,
//            actions: <Widget>[
//              IconButton(
//                  icon: const Icon(Icons.shopping_cart),
//                  tooltip: 'Shopping cart',
//                  onPressed: _showShoppingCart
//              ),
//              PopupMenuButton<ShrineAction>(
//                  itemBuilder: (BuildContext context) => <PopupMenuItem<ShrineAction>>[
//                    const PopupMenuItem<ShrineAction>(
//                        value: ShrineAction.sortByPrice,
//                        child: Text('Sort by price')
//                    ),
//                    const PopupMenuItem<ShrineAction>(
//                        value: ShrineAction.sortByProduct,
//                        child: Text('Sort by product')
//                    ),
//                    const PopupMenuItem<ShrineAction>(
//                        value: ShrineAction.emptyCart,
//                        child: Text('Empty shopping cart')
//                    )
//                  ],
//                  onSelected: (ShrineAction action) {
//                    switch (action) {
//                      case ShrineAction.sortByPrice:
//                        setState(_sortByPrice);
//                        break;
//                      case ShrineAction.sortByProduct:
//                        setState(_sortByProduct);
//                        break;
//                      case ShrineAction.emptyCart:
//                        setState(_emptyCart);
//                        break;
//                    }
//                  }
//              )
//            ]
//        ),
//        floatingActionButton: widget.floatingActionButton,
//        body: NotificationListener<ScrollNotification>(
//            onNotification: _handleScrollNotification,
//            child: widget.body
//        )
//    );
//  }
//}
//
////class MyApp extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
////        statusBarIconBrightness: Brightness.light
////    ));
////    return MaterialApp(
////      title: 'Flutter Demo',
////      color: Theme.CustomColors.greenBlue[500],
////      theme: Theme.CustomTheme,
////      home: LandingPage(title: 'witch app'),
////    );
////  }
////}
//
////class LandingPage extends StatelessWidget {
////  LandingPage({Key key, this.title}) : super(key: key);
////  final String title;
////
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: new Image.asset('assets/witch-app-white.png', fit: BoxFit.cover),
////       ),//Text(this.title),
////      body: Center(
////        child: Text(
////            "hello this is app",
////         style: TextStyle(
////           fontSize: 30.0,
////           color: Theme.CustomColors.darkPink[500]
////         ),
////        )
////      ),
////      backgroundColor: Theme.CustomColors.lightPink[500],
////    );
////  }
////}
//
//class Vendor {
//  const Vendor({
//    this.name,
//    this.description,
//    this.avatarAsset,
//    this.avatarAssetPackage,
//  });
//
//  final String name;
//  final String description;
//  final String avatarAsset;
//  final String avatarAssetPackage;
//
//  bool isValid() {
//    return name != null &&
//        description != null &&
//        avatarAsset != null;
//  }
//
//  @override
//  String toString() => 'Vendor($name)';
//}
//
//const String _kGalleryAssetsPackage = 'flutter_gallery_assets';
//const Vendor _sandra = Vendor(
//    name: 'Sandra’s shop',
//    avatarAsset: 'people/square/sandra.png',
//    avatarAssetPackage: _kGalleryAssetsPackage,
//    description:
//    'Sandra specializes in furniture, beauty and travel products with a classic vibe. '
//        'Custom orders are available if you’re looking for a certain color or material.'
//);
//const List<Product> _allProducts = <Product> [
//  Product(
//      name: 'Vintage Brown Belt',
//      imageAsset: 'products/belt.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//      categories: <String>['fashion', 'latest'],
//      price: 300.00,
//      vendor: _sandra,
//      description:
//      'Isn’t it cool when things look old, but they\'re not. Looks Old But Not makes '
//          'awesome vintage goods that are super smart. This ol’ belt just got an upgrade. '
//  ),
//  Product(
//      name: 'Sunglasses',
//      imageAsset: 'products/sunnies.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//      categories: <String>['travel', 'fashion', 'beauty'],
//      price: 20.00,
//      vendor: _sandra,
//      description:
//      'Be an optimist. Carry Sunglasses with you at all times. All Tints and '
//          'Shades products come with polarized lenses and super duper UV protection '
//          'so you can look at the sun for however long you want. Sunglasses make you '
//          'look cool, wear them.'
//  ),
//  Product(
//      name: 'Flatwear',
//      imageAsset: 'products/flatwear.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//      categories: <String>['furniture'],
//      price: 30.00,
//      vendor: _sandra,
//      description:
//      'Leave the tunnel and the rain is fallin amazing things happen when you wait'
//  ),
//  Product(
//      name: 'Salmon Sweater',
//      imageAsset: 'products/sweater.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//      categories: <String>['fashion'],
//      price: 300.00,
//      vendor: _sandra,
//      description:
//      'Looks can be deceiving. This sweater comes in a wide variety of '
//          'flavors, including salmon, that pop as soon as they hit your eyes. '
//          'Sweaters heat quickly, so savor the warmth.'
//  ),
//];
//
//List<Product> allProducts() {
//  assert(_allProducts.every((Product product) => product.isValid()));
//  return List<Product>.unmodifiable(_allProducts);
//}
