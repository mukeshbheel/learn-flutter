import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({Key? key}) : super(key: key);

  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Container'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Flexible(
                flex: 6,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isSelected ? 300 : 350,
                    height: _isSelected ? 300 : 600,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 3
                      ),
                      color:
                          _isSelected ? Colors.amber : Colors.deepOrangeAccent,
                    ),
                    child: Center(
                      child: Text(_isSelected ? 'Small yello box' : 'Big orange box', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          _isSelected ? Icons.toggle_on : Icons.toggle_off,
                          size: 50,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSelected = !_isSelected;
                          });
                        },
                      ),
                    ],
                  )),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
