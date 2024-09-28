import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/screen/Fighting_Corona_Screen/Fighting_Corona.dart';
import 'package:ecommerce/screen/Groceries_Screen/Groceries_Screen.dart';
import 'package:ecommerce/screen/Lighting_tools_Screen/lighting_%20tools.dart';
import 'package:ecommerce/screen/clothes_screen/clothes_screen.dart';
import 'package:ecommerce/screen/electronic_devices_screen/Electronic_Devices_Screen.dart';
import 'package:ecommerce/screen/sport-screen/sport_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return BlocConsumer<AppCubitCubit, AppCubitState>(
      listener: (context, state) {
        if (state is GetHomeDataSucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categories fetched successfully'),
              backgroundColor: Colors.green,  
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
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,  
                horizontal: screenWidth * 0.03,  
              ),
              child: GridView.builder(
                itemCount: categories!.data!.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 400 ? 2 : 3, 
                  mainAxisSpacing: screenHeight * 0.02,  
                  crossAxisSpacing: screenWidth * 0.02,  
                ),
                itemBuilder: (context, index) {
                  final category = cubit.categories!.data!.data![index];

                  return GestureDetector(
                    onTap: () {
                      if (categories.data!.data![index].name == 'اجهزه الكترونيه') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ElectronicDevicesScreen(),
                          ),
                        );
                      } else if (categories.data!.data![index].name == 'مكافحة كورونا') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FightingCorona(),
                          ),
                        );
                      } else if (categories.data!.data![index].name == 'رياضة') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SportScreen(),
                          ),
                        );
                      } else if (categories.data!.data![index].name == 'ادوات الاناره') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Lightingtools(),
                          ),
                        );
                      } else if (categories.data!.data![index].name == 'ملابس') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClothesScreen(),
                          ),
                        );
                      } else if (categories.data!.data![index].name == 'البقالة') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GroceriesScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${categories.data!.data![index].name} category tapped!'),
                            backgroundColor: Colors.blue,  
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
                            style: TextStyle(
                              color: Colors.black,  
                              fontWeight: FontWeight.bold,  
                              fontSize: screenWidth * 0.04,  
                            ),
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
