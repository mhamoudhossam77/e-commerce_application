import 'package:ecommerce/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:ecommerce/cubit/app_cubit/app_cubit_state.dart';
import 'package:ecommerce/model/categories-model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< AppCubitCubit,   AppCubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit =AppCubitCubit.get(context);
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 13),
            child: GridView.builder(
                itemCount: cubit.category!.data!.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        // Expanded(
                        //   child: Image.network(
                             
                            
                        //   )
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                         
                      ],
                    ),
                  );
                }));
      },
    );
  }
}
