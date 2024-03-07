import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_example/cubit/counter_cubit.dart';
import 'package:test_example/cubit/networkloading_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          lazy: true,
          create: (_) => CounterCubit(),
        ),
        BlocProvider<NetworkloadingCubit>(
          create: (_) => NetworkloadingCubit(),
        ),
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Cubit'),
      ),
      body: Column(
        children: [
          Center(
              child: BlocConsumer<CounterCubit, int>(builder: (context, state) {
            return Text('The value is $state');
          }, listener: (context, state) {
            print(state);
          })),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add')),
              TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  icon: Icon(Icons.remove),
                  label: Text('Minus')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).loading();
                },
                child: Text('Loading'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).success();
                },
                child: Text('Success'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).fail();
                },
                child: Text('Fail'),
              )
            ],
          ),
          BlocBuilder<NetworkloadingCubit, NetworkloadingState>(
            builder: (context, state) {
              if (state is NetworkSuccess) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (_, postiton) {
                        return Center(child: Text(state.data[postiton]));
                      }),
                );
              } else if (state is NetworkFailure) {
                return Text(state.error);
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
