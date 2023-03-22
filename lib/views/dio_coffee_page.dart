import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_package_sample/models/api/request/coffee.dart';
import 'package:flutter_package_sample/repositories/api/coffee_repository.dart';

// Repository(APIの取得)の状態を管理する
final coffeeRepositoryProvider = Provider((ref) => CoffeeRepository());

// 上記を非同期で管理する
final listProvider = FutureProvider<List<Coffee>>((ref) async {
  final repository = ref.read(coffeeRepositoryProvider);
  return await repository.fetchList();
});

class DioCoffeePage extends ConsumerWidget {
  const DioCoffeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //取得したAPIデータの監視
    final asyncValue = ref.watch(listProvider);

    return Scaffold(
      body: Center(
        child: asyncValue.when(
          data: (data) {
            return data.isNotEmpty
                ? ListView(
                    children: data
                        .map(
                          (Coffee coffee) => Card(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(coffee.title!),
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(coffee.description!),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(coffee.title!),
                                subtitle: Text(coffee.description!),
                                trailing: const Icon(Icons.more_vert),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : const Text('Data is empty.');
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
