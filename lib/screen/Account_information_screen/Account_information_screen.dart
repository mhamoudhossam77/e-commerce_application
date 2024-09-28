import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var cubit = AppCubitCubit.get(context);
 
    nameController.text = cubit.userModel?.data?.name ?? '';
    emailController.text = cubit.userModel?.data?.email ?? '';
    phoneController.text = cubit.userModel?.data?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.yellow[700] ,
        title: Text('Edit Profile'),
      ),
      body: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
            
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);  
          } else if (state is UpdateUserDataError) {
           
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error updating profile!'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          var cubit = AppCubitCubit.get(context);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.yellow[700]), 
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.yellow[700]),  
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.yellow[700]), // Highlight label
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  state is UpdateUserDataLoading
                      ? CircularProgressIndicator()  
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              
                              cubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          child: Text('Save'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),  
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 
}
