import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CounterWidget extends StatefulWidget {
  int initialValue;
  final Function(int value) onIncrement;
  final Function(int value) onDecrement;

  CounterWidget({
    Key? key,
    required this.initialValue,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const CircleAvatar(child: Icon(Icons.remove)),
          onPressed: () {
            if (widget.initialValue > 1) {
              setState(() {
                widget.initialValue--;
                widget.onDecrement(widget.initialValue);
              });
            }
          },
        ),
        Text(
          '${widget.initialValue}',
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        IconButton(
          icon: const CircleAvatar(
              child: Icon(
            Icons.add,
            color: Colors.blue,
          )),
          onPressed: () {
            setState(() {
              widget.initialValue++;
              widget.onIncrement(widget.initialValue);
            });
          },
        ),
      ],
    );
  }
}
