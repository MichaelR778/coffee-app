import 'package:coffee_app/admin/admin_root.dart';
import 'package:coffee_app/features/auth/data/supabase_auth_repo.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:coffee_app/features/auth/presentation/pages/auth_page.dart';
import 'package:coffee_app/admin/image/data/supabase_image_repo.dart';
import 'package:coffee_app/features/item/data/supabase_item_repo.dart';
import 'package:coffee_app/features/item/presentation/cubits/item_cubit.dart';
import 'package:coffee_app/features/order/data/supabase_order_repo.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/theme/app_theme.dart';
import 'package:coffee_app/user/cart/data/supabase_cart_repo.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_cubit.dart';
import 'package:coffee_app/user/user_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = SupabaseAuthRepo();
    final itemRepo = SupabaseItemRepo();
    final imageRepo = SupabaseImageRepo();
    final cartRepo = SupabaseCartRepo();
    final orderRepo = SupabaseOrderRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo),
        ),
        BlocProvider<ItemCubit>(
          create: (context) => ItemCubit(
            itemRepo: itemRepo,
            imageRepo: imageRepo,
          ),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(
            cartRepo: cartRepo,
            itemRepo: itemRepo,
            authRepo: authRepo,
          ),
        ),
        BlocProvider<OrderCubit>(
          create: (context) =>
              OrderCubit(orderRepo: orderRepo, authRepo: authRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // unauthenticated
            if (state is Unauthenticated) {
              return const AuthPage();
            }

            // authenticated
            else if (state is Authenticated) {
              context.read<ItemCubit>().loadItem();

              if (state.role == "admin") {
                context.read<OrderCubit>().loadAllOrder();
                return const AdminRoot();
              } else {
                context.read<CartCubit>().loadCart();
                context.read<OrderCubit>().loadUserOrder();
                return const UserRoot();
              }
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
