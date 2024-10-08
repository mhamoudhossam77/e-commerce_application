import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/widget/ElectronicDeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({super.key});

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  @override
    void initState() {
    super.initState();
    AppCubitCubit.get(context).getCategorySport();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.yellow[700],
        title: const Text('Sports' , style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body:  BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {
           if(state is GetcategoriesDataError){
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: 
              Text("Error")
              ),
            );
           }
        },
        builder: (context, state) {
          var cubit = AppCubitCubit.get(context);

           
          if (cubit.categories_detalies?.data?.data == null) {
            return const Center(
              child: CircularProgressIndicator(),   
            );
          }

          
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: cubit.categories_detalies!.data!.data!.length,
            itemBuilder: (context, index) {
              var device = cubit.categories_detalies!.data!.data![index];
              return ElectronicDeviceCard(
                name: device.name ?? 'Unknown Device',
                imageUrl: device.image ?? 'https://example.com/placeholder.png',
                price: device.price?.toString() ?? '0',
                
              );
            },
          );
        },
      ),
    );
  }
}