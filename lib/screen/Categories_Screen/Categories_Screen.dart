import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key}); 

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  
  @override

  void initState() {
    super.initState();
    AppCubitCubit.get(context).getCategoriesData();
  }
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitCubit, AppCubitState>(
      listener: (context, state)
 {
        if (state is  GetHomeDataSucess) {  
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categories fetched successfully'),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = AppCubitCubit.get(context);

        if (state is  GetcategoriesDataLoading||cubit.categories == null) {  
          return const Center(child: CircularProgressIndicator());
        } else if (state is  GetcategoriesDataError) {
                  return const Center(child: Text('Error fetching categories'));

        } else {
             final categories = cubit.categories;
          if (categories?.data?.data != null) {  
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
              child: GridView.builder(
                itemCount: categories!.data!.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                
                  return Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            cubit.categories!.data!.data![index].image!,  
                             
                          ),
                        ),
                       const SizedBox(height: 10),
                         Text(
                          cubit.categories!.data!.data![index].name!,
                          textAlign: TextAlign.center,
                       ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            
            return const Center(child: Text('No categories found'));
          }
        }
      },
    );
  }
}