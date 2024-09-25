import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    AppCubitCubit.get(context).getallCarts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitCubit, AppCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubitCubit.get(context);
        if (state is GetCartLoading || cubit.cartModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetCartError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Error while getting favourites",
                ),
                TextButton(
                  onPressed: () {
                    AppCubitCubit.get(context).getallCarts();
                  },
                  child: const Text(
                    "Reload",
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(cubit.cartModel!.data!.cartItems![index].product!.image!),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.cartModel!.data!.cartItems![index].product!.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color:  Colors.black, 
                              ),
                            ),
                            Text(
                              cubit.cartModel!.data!.cartItems![index].product!.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${cubit.cartModel!.data!.cartItems![index].product!.price!.toString()} EGP",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.yellow[700],  
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[700], 
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 8,
                              ),
                              child: Center(
                                child: Text(
                                  "${cubit.cartModel!.data!.cartItems![index].product!.discount!.toString()}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: cubit.cartModel!.data!.cartItems!.length,
            ),
          );
        }
      },
    );
  }
}
