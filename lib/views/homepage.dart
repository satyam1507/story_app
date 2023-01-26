import 'package:flutter/material.dart';
import '../models/dataModel.dart';
import '../services/dataservice.dart';
import 'infinitestorypage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> data = [];
  List<Product> data2 = [];

  @override
  void initState() {
    super.initState();
    DataService().getProducts().then((value) {
      setState(() {
        data = value;
        for (int i = 0; i < value.length; i++) {
          if (value[i].images.length == 1) {
            data2.add(value[i]);
            break;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryPage(
                            data: ProductList(
                              products: data2,
                              total: data2.length,
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('SingleStory'),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryPage(
                            data: ProductList(
                              products: data,
                              total: data.length,
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'InfiniteList',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
