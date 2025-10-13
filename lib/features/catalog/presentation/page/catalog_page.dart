import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/core/widgets/product_list_modal.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/features/catalog/presentation/catalog.dart';
import 'package:smart_catalog/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CatalogCubit(catalogRepository: getIt<CatalogRepository>()),
      child: BlocListener<CatalogCubit, CatalogState>(
        listener: (context, state) {
          if (state is CatalogError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.message),
            );
          }
          if (state is ProductsLoaded) {
            showCustomMultiSelectionModal(
              context: context,
              title: "catalog.select_products".tr(),
              subtitle: "catalog.select_products_subtitle".tr(),
              products: state.products,
              buttonName: "catalog.add".tr(),
              addProductsToCart: (selectedList) {
                context.read<CatalogCubit>().addProductsCodeToCart(
                  selectedList,
                );
              },
            );
          }
          if (state is ProductsAddedToCart) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: "success.products_added_to_cart".tr(),
              ),
            );
          }
          if (state is CatalogNavigatingToCart) {
            context.pushNamed(AppPaths.cart);
          }
        },
        child: BlocBuilder<CatalogCubit, CatalogState>(
          builder: (context, state) {
            return Stack(
              children: [
                CatalogView(imageUrls: imageUrls),
                if (state is CatalogLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
