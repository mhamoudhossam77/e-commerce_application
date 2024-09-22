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
    // Fetch user data when the screen initializes
    AppCubitCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {
          // Handle any side-effects if needed
        },
        builder: (context, state) {
          var cubit = AppCubitCubit.get(context);

          // Show a loading indicator while data is being fetched
          if (state is GetUserDataLoading || cubit.userModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Once data is fetched, display the profile details
          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Picture and Name
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: cubit.userModel!.data!.image != null
                            ? NetworkImage(cubit.userModel!.data!.image!)
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider, // Default image
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cubit.userModel!.data!.name ??
                            'John Doe', // Fallback for name
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        cubit.userModel!.data!.email ?? 'No email available',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Options
                const SizedBox(height: 20),
                ProfileOption(
                  icon: Icons.person,
                  title: 'Account Information',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AccountInformationScreen(),
                      ),
                    );
                  },
                ),
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Navigate to Settings Screen
                  },
                ),
                ProfileOption(
                  icon: Icons.security,
                  title: 'Privacy',
                  onTap: () {
                    // Navigate to Privacy Screen
                  },
                ),
                ProfileOption(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                    // Navigate to Help & Support Screen
                  },
                ),
                BlocConsumer<AppCubitCubit, AppCubitState>(
                  listener: (context, state) {
                    if (state is Logoutsucess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Sucess Logout")));
                    }
                  },
                  builder: (context, state) {
                    if (state is LogoutLoading) {
                      return Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      );
                    } else if (state is LogoutError) {
                      return Column(
                        children: [
                          Center(
                            child: Text("Error"),
                          )
                        ],
                      );
                    } else {
                      return ProfileOption(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          AppCubitCubit.get(context).Logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
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
