 import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/screen/Account_information_screen/Account_information_screen.dart';
import 'package:ecommerce/screen/login-screen/login-screen.dart';
import 'package:ecommerce/widget/profile-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
   
    AppCubitCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor:  Colors.yellow[700],
      ),
      body: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {
           
          if (state is UpdateUserDataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ));
          } else if (state is UpdateUserDataError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error updating profile!'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          var cubit = AppCubitCubit.get(context);
 
          if (state is GetUserDataLoading || cubit.userModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

           
          return SingleChildScrollView(
            child: Column(
              children: [
                 
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,  
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.13,  
                        backgroundImage: cubit.userModel?.data?.image != null
                            ? NetworkImage(cubit.userModel?.data?.image ?? '')
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider,  
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        cubit.userModel?.data?.name ?? 'John Doe',  
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,  
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[700],  
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        cubit.userModel?.data?.email ?? 'No email available',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

               
                SizedBox(height: screenHeight * 0.03),
                ProfileOption(
                  icon: Icons.person,
                  title: 'Account Information',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    );
                  },
                  highlightColor: Colors.yellow[700],  
                ),
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                     
                  },
                  highlightColor: Colors.yellow[700],  
                ),
                ProfileOption(
                  icon: Icons.security,
                  title: 'Privacy',
                  onTap: () {
                   
                  },
                  highlightColor: Colors.yellow[700],  
                ),
                ProfileOption(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                  
                  },
                  highlightColor: Colors.yellow[700],  
                ),
                BlocConsumer<AppCubitCubit, AppCubitState>(
                  listener: (context, state) {
                    if (state is Logoutsucess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: const Text("Success Logout")));
                    }
                  },
                  builder: (context, state) {
                    if (state is LogoutLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LogoutError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    } else {
                      return ProfileOption(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          AppCubitCubit.get(context).Logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        highlightColor: Colors.red, 
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}