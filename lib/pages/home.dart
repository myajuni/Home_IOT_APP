import 'package:flutter/material.dart';
import 'package:project/pages/device.dart';
import 'package:project/utils/extensions/color_ext.dart';

class _DeviceCard extends StatefulWidget {
  final String name;
  final String info;
  final String src;
  final bool broken;

  const _DeviceCard(this.name, this.info, this.src, this.broken);

  @override
  State<_DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<_DeviceCard> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: flag ? Colors.white : Colors.black.lighten(50),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DevicePage(
                name: widget.name,
                info: widget.info,
                src: widget.src,
                broken: widget.broken,
              ),
            ),
          );
        },
        child: SizedBox(
          width: 140,
          height: 140,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(widget.src),
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      colorBlendMode: BlendMode.multiply,
                      color: flag ? Colors.transparent : Colors.black.lighten(50),
                    ),
                    Text(widget.name),
                    Text(widget.info),
                  ],
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: SizedBox(
                    width: 45,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        onChanged: (value) {
                          setState(() {
                            flag = value;
                          });
                        },
                        value: flag,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget _buildRoutineButton({required String label, required String src}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipOval(
              child: Image.asset(src, fit: BoxFit.contain),
            ),
          ),
        ),
        Text(label)
      ],
    );
  }

  Widget _buildRoutineSection() {
    return Column(
      children: [
        _buildSectionHeader([
          const Text('스마트 모드'),
        ]),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: _buildRoutineButton(
                      label: '취침 모드', src: 'images/profile_off.png')),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {},
                  child: _buildRoutineButton(
                      label: '절약 모드', src: 'images/profile_off.png')),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [Icon(Icons.add), Text('추가')],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withAlpha(73)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 0, 16.0),
        child: Row(
          children: children,
        ),
      ),
    );
  }

  Widget _buildDeviceCard(String name, String info, String src, bool broken) {
    return _DeviceCard(name, info, src, broken);
  }

  Widget _buildDeviceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader([const Text('거실')]),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              _buildDeviceCard('세탁기', '1:25 남음', 'images/washer.png', true),
              _buildDeviceCard('에어컨', '25C', 'images/air_conditioner.png', false),
              _buildDeviceCard('조명', '켜짐', 'images/light.png', false),
              _buildDeviceCard('TV', '꺼짐', 'images/tv.png', true),
              SizedBox(
                width: 140,
                height: 140,
                child: Card(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        alignment: Alignment.center,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          const Text('우리집'),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_drop_down))
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ],
    );
  }

  Widget _buildMarketingZone() {
    return Container(
      height: 160.0,
      decoration: const BoxDecoration(color: Colors.grey),
      child: const Center(
        child: Text('Marketing zone'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _buildAppBar(),
        // _buildMarketingZone(),
        _buildRoutineSection(),
        _buildDeviceSection(),
      ]),
    );
  }
}