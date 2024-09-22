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
           
        },
        builder: (context, state) {
           var cubit = AppCubitCubit.get(context);

          
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

                 
                AccountInfoField(
                  label: 'Full Name',
                  value: cubit.userModel!.data!.name!,
                ),

                 
                AccountInfoField(
                  label: 'Email',
                  value: cubit.userModel!.data!.email!,
                ),

                
                AccountInfoField(
                  label: 'Phone Number',
                  value:  cubit.userModel!.data!.phone!,
                ),

                
             

                SizedBox(height: 40),

                
                Center(
                  child: ElevatedButton(
                    onPressed: () {
            
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
