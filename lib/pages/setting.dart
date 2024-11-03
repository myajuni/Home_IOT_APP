import 'package:flutter/material.dart';
import 'package:project/utils/extensions/color_ext.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget _buildAccountButton(String text) {
    return Container(
      width: 90,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: TextButton(
        child: Text(text, style: const TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }

  Widget _buildAccountButtonGroup() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAccountButton('멤버십'),
          const Divider(color: Colors.white, height: 12.0, thickness: 5.0),
          _buildAccountButton('가입하기'),
          const Divider(color: Colors.white, height: 12.0, thickness: 1.0),
          _buildAccountButton('리워드'),
        ],
      ),
    );
  }

  Widget _buildMarketingZone() {
    return Container(
      height: 80.0,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: const Center(
        child: Text('Marketing zone'),
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 30,
          maxRadius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipOval(
              child: Image.asset('images/profile.png', fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        const Text('김혜준'),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right)),
        Expanded(child: Container()),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      children: [
        _buildAccountInfo(),
        const SizedBox(height: 12.0),
        _buildAccountButtonGroup(),
      ],
    );
  }

  Widget _buildQuickMenuButton({required String label, required String src}) {
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
        const SizedBox(height: 8.0),
        Text(label, style: const TextStyle(color: Colors.white))
      ],
    );
  }

  Widget _buildQuickMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.lighten(40),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: _buildQuickMenuButton(
              label: '에너지',
              src: 'images/energy.png',
            ),
          ),
          TextButton(
            onPressed: () {},
            child: _buildQuickMenuButton(
              label: '문의하기',
              src: 'images/ask.png',
            ),
          ),
          TextButton(
            onPressed: () {},
            child: _buildQuickMenuButton(
              label: '공지사항',
              src: 'images/notice.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListMenuTile(String text, String src) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipOval(
            child: Image.asset(src, fit: BoxFit.contain),
          ),
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildListMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제품 사용과 관리',
          style: TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
          decoration: BoxDecoration(
            color: Colors.black.lighten(40),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              _buildListMenuTile('스마트 케어', 'images/smart_care.png'),
              Container(
                  padding: const EdgeInsets.only(left: 60),
                  child: const Divider()),
              _buildListMenuTile('챗봇', 'images/chatbot.png'),
              Container(
                  padding: const EdgeInsets.only(left: 60),
                  child: const Divider()),
              _buildListMenuTile('제품 정보와 보증', 'images/product_info.png'),
              Container(
                  padding: const EdgeInsets.only(left: 60),
                  child: const Divider()),
              _buildListMenuTile('제품 사용 설명서', 'images/docs.png'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildAccountSection(),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildQuickMenuSection(),
                      const SizedBox(height: 12.0),
                      _buildListMenuSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
