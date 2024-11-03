import 'package:flutter/material.dart';
import 'package:project/utils/extensions/color_ext.dart';

class DevicePage extends StatefulWidget {
  final String name;
  final String info;
  final String src;
  final bool broken;
  final bool flag;

  const DevicePage({
    super.key,
    required this.name,
    required this.info,
    required this.src,
    required this.broken,
    required this.flag,
  });

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  Widget _buildDeviceControlBase(List<Widget> content) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...content,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_left),
                ),
                const Text('1'),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAlertMessage() {
    return SizedBox(
      height: 60,
      child: Card(
        color: Colors.red.lighten(50),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
          child: Row(
            children: [
              const Icon(Icons.warning),
              const SizedBox(width: 16.0),
              const Text('이 기기는 점검이 필요해요'),
              Expanded(child: Container()),
              Text('확인 하기', style: TextStyle(color: Colors.blue.darken())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceControl1() {
    return _buildDeviceControlBase([
      const Text(
        '단계',
        style: TextStyle(fontSize: 16.0),
      ),
    ]);
  }

  get controls => [_buildDeviceControl1()];
  late bool flag = widget.flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          widget.broken ? _buildAlertMessage() : Container(),
          Image(
            image: AssetImage(widget.src),
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              Expanded(child: Container()),
              Switch(
                  value: flag,
                  onChanged: (value) {
                    setState(() {
                      flag = value;
                    });
                  })
            ],
          ),
          controls[0],
        ],
      ),
    );
  }
}
