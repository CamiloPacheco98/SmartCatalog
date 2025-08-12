import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/core/widgets/custom_multi_selection_modal.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/features/catalog/presentation/catalog.dart';
import 'package:smart_catalog/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CatalogCubit(catalogRepository: getIt<CatalogRepository>()),
      child: BlocListener<CatalogCubit, CatalogState>(
        listener: (context, state) {
          if (state is ProductsCodeError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.message),
            );
          }
          if (state is ProductsCodeLoaded) {
            showCustomMultiSelectionModal(
              context: context,
              title: "catalog.select_products".tr(),
              subtitle: "catalog.select_products_subtitle".tr(),
              options: state.productsCode,
              buttonName: "catalog.add".tr(),
              onSelected: (selectedList) {
                debugPrint("Selected options: $selectedList");
              },
            );
          }
        },
        child: BlocBuilder<CatalogCubit, CatalogState>(
          builder: (context, state) {
            return Stack(
              children: [
                const CatalogView(),
                if (state is ProductsCodeLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
