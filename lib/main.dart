import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/application_bloc.dart';
import 'package:flutter_app_bloc/bloc_provider.dart';
import 'package:flutter_app_bloc/increment_bloc.dart';

void main() {
  runApp(BlocProvider<ApplicationBloc>(
    child: Myapp(),
    bloc: ApplicationBloc(),
  ));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc counterBloc = BlocProvider.of<IncrementBloc>(context);
    final ApplicationBloc appBloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de uso de Stream'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: counterBloc.outCounter,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text('You Hit me: ${snapshot.data} times');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          counterBloc.incrementCounter.add(null);
        },
      ),
    );
  }
}
