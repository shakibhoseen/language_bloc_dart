import 'package:first_project/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitScreen extends StatelessWidget {
  const CubitScreen({super.key});

  Widget build(BuildContext context) {
    final local = CounterCubit();
    final local2 = CounterCubit();
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
        children: [
          BlocBuilder<CounterCubit, int>(
            bloc: local,
            builder: (context, count) => Center(child: Text('$count')),
          ),
          SizedBox(height: 20,),
          BlocBuilder<CounterCubit, int>(
            bloc: local2,
            builder: (context, count) => Center(child: Text('$count')),
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => local.increment(),//context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => local2.increment(),
          ),
        ],
      ),
    );
  }
}
