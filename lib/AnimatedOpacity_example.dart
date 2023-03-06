import 'package:flutter/material.dart';

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({Key? key}) : super(key: key);

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  int _selectedBlock = 0;
  Color _selectedColor = Colors.grey;
  String _selectedColorName = 'No Color Selected';
  final List<Map<String, dynamic>> _boxes = [
    {
      'id': 1,
      'name':'Orange',
      'color': Colors.orangeAccent,
    },
    {
      'id': 2,
      'name':'Red',
      'color': Colors.red,
    },
    {
      'id': 3,
      'name':'Green',
      'color': Colors.green,
    },
    {
      'id': 4,
      'name':'Pink',
      'color': Colors.pink,
    },
    {
      'id': 5,
      'name':'Blue',
      'color': Colors.blue,
    },
    {
      'id': 6,
      'name':'Purple',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Opacity'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runSpacing: 20,
                spacing: 20,
                // direction: Axis.horizontal,
                children: [
                  ..._boxes.map(
                    (e) => GestureDetector(
                      onTap: () => setState(() {
                        if(_selectedBlock == e['id']){
                          _selectedBlock = 0;
                          _selectedColor = Colors.grey;
                          _selectedColorName = "No Color Selected";
                        }else{
                          _selectedColor = e['color'];
                          _selectedBlock = e['id'];
                          _selectedColorName = e['name'];
                        }
                      }),
                      child: AnimatedOpacity(
                        opacity: _selectedBlock == e['id'] ? 1 : 0.4,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: e['color'],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 3)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Center(child: Text(_selectedColorName, style: TextStyle(color: _selectedColor, fontSize: 16, fontWeight: FontWeight.bold),),)
          ],
        ),
      ),
    );
  }
}
