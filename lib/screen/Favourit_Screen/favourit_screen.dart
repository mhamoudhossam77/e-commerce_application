import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    AppCubitCubit.get(context).getallfavourit();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitCubit,AppCubitState>(
      listener: (context, state) {

      },
      builder:(context, state) {
        var cubit = AppCubitCubit.get(context);
        if(state is GetFavouritesLoading || cubit.favouriteModel == null)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        else if(state is GetFavouritesError){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Error while getting favourites",
                ),
                TextButton(
                    onPressed: (){
                      AppCubitCubit.get(context).getallfavourit();
                    },
                    child: const Text(
                      "Reload",
                    ),
                ),
              ],
            ),
          );
        }
        else{
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemBuilder:  (context, index) {

                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,child: Image.network(cubit.favouriteModel!.data!.favouriteData![index].product!.image!)),
                        Expanded(
                          flex: 2,
                          child
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  cubit.favouriteModel!.data!.favouriteData![index].product!.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cubit.favouriteModel!.data!.favouriteData![index].product!.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cubit.favouriteModel!.data!.favouriteData![index].product!.price.toString()} EGP",
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.deepPurple,
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
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25.0),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 8,
                                ),
                                child: Center(
                                  child: Text(
                                      "${cubit.favouriteModel!.data!.favouriteData![index].product!.discount!.toString()}%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.ChangeProductFavourit(Id: cubit.favouriteModel!.data!.favouriteData![index].product!.id!);
                              },
                              icon:  Icon(
                                cubit.favmap[cubit.favouriteModel!.data!.favouriteData![index].product!.id]!?
                                Icons.favorite_outlined:Icons.favorite_outline,
                                color: cubit.favmap[cubit.favouriteModel!.data!.favouriteData![index].product!.id]!? Colors.red:Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              itemCount: cubit.favouriteModel!.data!.favouriteData!.length,
            ),
          );
        }
      },

    );
  }
}