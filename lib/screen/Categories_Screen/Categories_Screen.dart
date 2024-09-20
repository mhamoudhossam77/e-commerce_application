 import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key}); 


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitCubit, AppCubitState>(
      listener: (context, state)
 {
        if (state is  GetHomeDataSucess) { // Assuming the actual state is CategoriesFetched
          // Handle successful category fetching (e.g., show a snackbar)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categories fetched successfully'),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = AppCubitCubit.get(context);

        if (state is  GetHomeDataLoading) { // Assuming the actual loading state is CategoriesLoading
          // Show a loading indicator while fetching categories
          return const Center(child: CircularProgressIndicator());
        } else if (state is  GetHomeDataSucess) {
          final categories = cubit.categories;
          if (categories?.data?.data != null) { // Check for null before accessing nested properties
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
                  final category = categories.data!.data![index];
                  return Container(
                    child: Column(
                      children: [
                        // Expanded(
                        //   child: Image.network(
                        //     category.image, // Access image from the CategoryModel
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // Text(
                        //   category.data. // Access name from the CategoryModel
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            // Handle cases where categories data is null (e.g., empty data)
            return const Center(child: Text('No categories found'));
          }
        } else {
          // Handle errors or other states
          return const Center(child: Text('Error fetching categories'));
        }
      },
    );
  }
}