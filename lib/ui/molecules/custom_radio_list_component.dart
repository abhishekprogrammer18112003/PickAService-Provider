import 'dart:async';

import 'package:flutter/widgets.dart';
import '../atoms/custom_radio_tile.dart';

class CustomRadioList extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final void Function(String) onChanged;
  const CustomRadioList(
      {super.key,
      required this.options,
      required this.selectedOption,
      required this.onChanged});

  @override
  State<CustomRadioList> createState() => _CustomRadioListState();
}

class _CustomRadioListState extends State<CustomRadioList> {
  late StreamController<String> _radioController;

  @override
  void initState() {
    _radioController = StreamController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _radioController.add(widget.selectedOption);
    return StreamBuilder<String>(
        stream: _radioController.stream,
        initialData: widget.selectedOption,
        builder: (context, snapshot) {
          return Row(
            children: widget.options
                .map((e) => CustomRadioTile(
                      value: e,
                      groupValue: snapshot.data!,
                      onChanged: (p) {
                        _radioController.add(p);
                        return widget.onChanged(p);
                      },
                    ))
                .toList(),
          );
        });
  }
}
