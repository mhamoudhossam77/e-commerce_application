import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:ecommerce/product-Detalies-Screen/Product_detalis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    AppCubitCubit.get(context).getHomeData();
    AppCubitCubit.get(context).getCategoriesData();  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AppCubitCubit, AppCubitState>(
          listener: (context, state) {
            if (state is ChangeProductFavouriteSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Successfully added to favorites"),
                ),
              );
            }
            if (state is ChangeProductFavouriteError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Error adding to favorites"),
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = AppCubitCubit.get(context);

            if (cubit.homeModel?.data == null || cubit.homeModel?.data?.products == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetHomeDataError) {
              return Center(
                child: Column(
                  children: [
                    const Text("Error while getting home data"),
                    TextButton(
                      onPressed: () {
                        AppCubitCubit.get(context).getHomeData();
                      },
                      child: const Text("Reload"),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
                     
                    if (cubit.homeModel?.data?.banners != null &&
                        cubit.homeModel!.data!.banners!.isNotEmpty)
                      CarouselSlider(
                        items: makeSliderItem(cubit.homeModel!.data!.banners!),
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                    const SizedBox(height: 20.0),

                     
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,  
                      ),
                    ),
                    const SizedBox(height: 15.0),

                     
                    if (cubit.categories?.data?.data != null)
                      SizedBox(
                        height: 170.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.categories!.data!.data!.length,
                          itemBuilder: (context, index) {
                            var category = cubit.categories!.data!.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(
                                      category.image ?? 'https://via.placeholder.com/150',
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    category.name!,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,  
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    else if (state is GetcategoriesDataLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      const Center(
                        child: Text("Error loading categories"),
                      ),

                    const SizedBox(height: 15.0),

                    
                    const Text(
                      "All Products",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color:  Colors.black 
                      ),
                    ),
                    const SizedBox(height: 35.0),

                    
                    if (cubit.homeModel?.data?.products != null &&
                        cubit.homeModel!.data!.products!.isNotEmpty)
                      SizedBox(
                        height: 400,  
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,  
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: cubit.homeModel!.data!.products!.length,
                          itemBuilder: (context, index) {
                            var product = cubit.homeModel!.data!.products![index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsScreen(product: product),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            product.image ?? 'https://via.placeholder.com/150',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.network(
                                                'https://via.placeholder.com/150',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                          if (product.discount != 0)
                                            Container(
                                              width: 60,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${product.discount}% OFF",
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        product.name!,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,  
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${product.price!}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow[700],  
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cubit.changeProductFavourite(id: product.id!);
                                            },
                                            icon: Icon(
                                              cubit.favmap[product.id]!
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: cubit.favmap[product.id]!
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow[700],  
                                        ),
                                        onPressed: () {
                                          cubit.changeProductCart(id: product.id!);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Product added to cart!'),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Add to Cart",
                                          style: TextStyle(color: Colors.white),  
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Center(
                        child: Text("No products available"),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> makeSliderItem(List<Banners> allBanners) {
    return allBanners
        .map((banner) => Image.network(
              banner.image ?? "https://m.media-amazon.com/images/I/61mMytOBsJL._AC_SL1024_.jpg",
              fit: BoxFit.cover,
            ))
        .toList();
  }
}
