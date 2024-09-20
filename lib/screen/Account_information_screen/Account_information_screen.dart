import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/widget/AccountInfoField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer< AppCubitCubit,  AppCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
           var cubit = AppCubitCubit.get(context);

          // Show a loading indicator while data is being fetched
          if (state is GetUserDataLoading || cubit.userModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // Name Field
                AccountInfoField(
                  label: 'Full Name',
                  value: cubit.userModel!.data!.name!,
                ),

                // Email Field
                AccountInfoField(
                  label: 'Email',
                  value: cubit.userModel!.data!.email!,
                ),

                // Phone Number Field
                AccountInfoField(
                  label: 'Phone Number',
                  value:  cubit.userModel!.data!.phone!,
                ),

                
             

                SizedBox(height: 40),

                // Edit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to an edit screen or show dialog to edit information
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Edit Information',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
