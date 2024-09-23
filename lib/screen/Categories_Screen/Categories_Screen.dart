import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/screen/electronic_devices_screen/Electronic_Devices_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  // Import your Electronic Devices Screen

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitCubit, AppCubitState>(
      listener: (context, state) {
        if (state is GetHomeDataSucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categories fetched successfully'),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = AppCubitCubit.get(context);

        if (state is GetcategoriesDataLoading || cubit.categories == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetcategoriesDataError) {
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
                  final category = cubit.categories!.data!.data![index];

                  return GestureDetector(
                    onTap: () {
                      if (categories.data!.data![index].name == 'اجهزه الكترونيه') {
                        // Navigate to Electronic Devices Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ElectronicDevicesScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${categories.data!.data![index].name} category tapped!'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              category.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category.name!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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
