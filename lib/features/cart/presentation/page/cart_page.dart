import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/main.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/presentation/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(
        cartRepository: getIt<CartRepository>(),
        products: CartSession.instance.cartProducts,
      ),
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(message: state.message),
            );
          } else if (state is CartError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.message),
            );
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Stack(
              children: [
                CartView(products: state.products),
                if (state is CartLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
