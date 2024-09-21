import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/home-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubitCubit.get(context);
          if (state is GetHomeDataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetHomeDataError) {
            return Center(
              child: Column(
                children: [
                  Text("Error while getting home data"),
                  TextButton(
                      onPressed: () {
                        AppCubitCubit.get(context).getHomeData();
                      },
                      child: Text("Reload")),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: makeSliderItem(cubit.homeModel!.data!.banners!),
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "All products",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    SizedBox(
                      height: 230,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 12 / 9),
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.homeModel!.data!.products!.length,
                          itemBuilder: (context, index) {
                            var product =
                                cubit.homeModel!.data!.products![index];
                            return Card(
                                color: Colors.white,
                                child: Column(children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        product.image != null
                                            ? Image.network(
                                                width: double.infinity,
                                                product.image!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.network(
                                                    'https://via.placeholder.com/150',
                                                  );
                                                },
                                              )
                                            : Image.network(
                                                'https://via.placeholder.com/150',
                                              ),
                                        cubit.homeModel!.data!.products![index]
                                                    .discount! !=
                                                0
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    width: 50,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${cubit.homeModel!.data!.products![index].discount!}%",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                12.0), // Adjust font size
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      cubit.homeModel!.data!.products![index]
                                          .name!,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cubit.homeModel!.data!
                                              .products![index].price!
                                              .toString(),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite_outline))
                                      ],
                                    ),
                                  ),
                                ]));
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )),
    );
  }

  List<Widget> makeSliderItem(List<Banners> allBanners) {
    List<Widget> allImages = [];
    for (var element in allBanners) {
      allImages.add(
        Image.network(element.image ??
            "https://m.media-amazon.com/images/I/61mMytOBsJL._AC_SL1024_.jpg"),
      );
    }
    return allImages;
  }
}
