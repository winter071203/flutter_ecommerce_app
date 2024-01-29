import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winter_store/features/shop/models/brand_model.dart';
import 'package:winter_store/features/shop/models/product_attribute_model.dart';
import 'package:winter_store/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  String title;
  String? description;
  String? categoryId;
  // DateTime? createdAt;
  double price;
  double? salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.title,
    this.description,
    this.categoryId,
    // this.createdAt,
    required this.price,
    this.salePrice,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        stock: 0,
        title: '',
        price: 0.0,
        thumbnail: '',
        productType: '',
      );

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    if (documentSnapshot.data() != null) {
      final json = documentSnapshot.data()!;
      return ProductModel(
        id: documentSnapshot.id,
        stock: json['stock'],
        sku: json['SKU'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        categoryId: json['categoryId'] ?? '',
        // createdAt: json['createdAt']?.toDate(),
        price: double.parse((json['price'] ?? 0.0).toString()),
        salePrice: double.parse((json['salePrice'] ?? 0.0).toString()),
        thumbnail: json['thumbnail'] ?? '',
        isFeatured: json['isFeatured'] ?? false,
        brand: BrandModel.fromJson(json['Brand']),
        images: List<String>.from(json['Images']),
        productType: json['productType'] ?? '',
        productAttributes: List<ProductAttributeModel>.from(
          json['productAttributes']
              .map((e) => ProductAttributeModel.fromJson(e)),
        ),
        productVariations: List<ProductVariationModel>.from(
          json['productVariations']
              .map((e) => ProductVariationModel.fromJson(e)),
        ),
      );
    } else {
      return ProductModel.empty();
    }
  }
}
