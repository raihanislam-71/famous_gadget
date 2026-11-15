import 'package:get/get.dart';
import '../../cart/cart_screen.dart';
import '../../category/category_screen.dart';
import '../../category/product_by_category_screen.dart';
import '../../category/product_list_screen.dart';
import '../../category/sub_category_screen.dart';
import '../../product_details/out_of_stock_product_details_screen.dart';
import '../../product_details/product_details_screen.dart';
import '../../review/review_screen.dart';
import '../app_navigation.dart';
import 'route_helpers.dart';

class CatalogRoutes {
  CatalogRoutes._();

  static List<GetPage<void>> get pages => [
        GetPage<void>(
          name: AppRoutes.categories,
          page: () => RouteHelpers.webPage(const CategoryScreen()),
        ),
        GetPage<void>(
          name: '${AppRoutes.subCategory}/:categoryName',
          page: () => RouteHelpers.webPage(
            SubCategoryScreen(
                categoryName: RouteHelpers.stringArgument('categoryName')),
          ),
        ),
        GetPage<void>(
          name: '${AppRoutes.products}/:categoryName',
          page: () => RouteHelpers.webPage(
            ProductByCategoryScreen(
                categoryName: RouteHelpers.stringArgument('categoryName')),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.products,
          page: () => RouteHelpers.webPage(
              const ProductListScreen(title: 'All Products')),
        ),
        GetPage<void>(
          name: AppRoutes.search,
          page: () => RouteHelpers.webPage(
            ProductListScreen(
              title: 'Search Products',
              initialSearchActive: true,
              initialSearchQuery: RouteHelpers.stringArgument('searchQuery'),
            ),
          ),
        ),
        GetPage<void>(
          name: '${AppRoutes.productDetails}/:productId',
          page: () => RouteHelpers.webPage(
            ProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: '/products/detail/:productId',
          page: () => RouteHelpers.webPage(
            ProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.productDetails,
          page: () => RouteHelpers.webPage(
            ProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: '/products/detail',
          page: () => RouteHelpers.webPage(
            ProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: '${AppRoutes.outOfStockProduct}/:productId',
          page: () => RouteHelpers.webPage(
            OutOfStockProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'sony-xm5'),
            ),
          ),
        ),
        GetPage<void>(
          name: '/products/out-of-stock-details/:productId',
          page: () => RouteHelpers.webPage(
            OutOfStockProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'sony-xm5'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.outOfStockProduct,
          page: () => RouteHelpers.webPage(
            OutOfStockProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'sony-xm5'),
            ),
          ),
        ),
        GetPage<void>(
          name: '/products/out-of-stock-details',
          page: () => RouteHelpers.webPage(
            OutOfStockProductDetailsScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'sony-xm5'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.cart,
          page: () => RouteHelpers.webPage(const CartScreen()),
        ),
        GetPage<void>(
          name: '${AppRoutes.reviews}/:productId',
          page: () => RouteHelpers.webPage(
            ReviewScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: '/products/review/:productId',
          page: () => RouteHelpers.webPage(
            ReviewScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.reviews,
          page: () => RouteHelpers.webPage(
            ReviewScreen(
              productId: RouteHelpers.stringArgument('productId',
                  fallback: 'anker-r50i'),
            ),
          ),
        ),
      ];
}
