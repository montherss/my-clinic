import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';

class StateScreen extends StatelessWidget {
  const StateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Text("Hi all");
      },
    );
  }
}

