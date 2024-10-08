import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/widget/ElectronicDeviceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectronicDevicesScreen extends StatefulWidget {
  const ElectronicDevicesScreen({super.key});

  @override
  State<ElectronicDevicesScreen> createState() =>
      _ElectronicDevicesScreenState();
}

class _ElectronicDevicesScreenState extends State<ElectronicDevicesScreen> {
  @override
  void initState() {
    super.initState();
    AppCubitCubit.get(context).getCategoryElectronicDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Electronic Devices',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),  
        ),
        backgroundColor:  Colors.yellow[700],  
      ),
      body: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {
          if (state is GetcategoriesDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: const Text("Error"),
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
