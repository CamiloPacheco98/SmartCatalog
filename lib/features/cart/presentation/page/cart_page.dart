import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/main.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/presentation/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(cartRepository: getIt<CartRepository>()),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Stack(
            children: [
              CartView(products: state is CartLoaded ? state.products : []),
              if (state is CartLoading) const CustomLoading(),
            ],
          );
        },
      ),
    );
  }
}
