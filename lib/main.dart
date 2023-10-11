import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_jok_app/ApiHelper.dart';
import 'package:random_jok_app/DataProvider.dart';
import 'package:random_jok_app/ListModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sp;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Random Joke',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Random Joke'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false).addToFav(
                    ListModal(
                        joke: dataProvider.randomjokeModal?.value ?? '',
                        date: DateTime.now().toString()));
              },
              icon: const Icon(Icons.favorite_rounded))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.black12,
                height: 110,
                width: double.infinity,
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: ApiHelper.apiHelper.getData(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }else{
                      Provider.of<DataProvider>(context, listen: false)
                          .modalData(snapshot.data);
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         snapshot.data?.value ?? '',
                         style: const TextStyle(fontWeight: FontWeight.bold),
                       ),
                     );
                    }
                  },
                ),
              ),
            ),
            Expanded(child: Consumer<DataProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.favList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.favList[index].joke),
                      subtitle: Text(value.favList[index].date),
                      trailing: InkWell(
                          onTap: () {
                            dataProvider.removeToFav(index);
                          },
                          child: const Icon(Icons.delete_outline)),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
            .copyWith(top: 0),
        child: ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('Fetch My Laugh')),
      ),
    );
  }
}
