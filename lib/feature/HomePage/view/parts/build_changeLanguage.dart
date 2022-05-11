part of home_view.dart;

class changeLanguage extends StatelessWidget {
  const changeLanguage({Key? key, required this.isdarkmode}) : super(key: key);
  final isdarkmode;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Uygulama Dilini Değiştir"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Lütfen Uygulama dilini Seçiniz"),
          DropdownButton<String>(
            value: "TR",
            items: [
            DropdownMenuItem(
              value: "TR",
              child: Text("Türkçe"),
            ),
            DropdownMenuItem(
              value: "EN",
              child: Text("İngilizce"),
            )
          ], onChanged: (value) {}),
        ],
      ),
      actions: [],
    );
  }
}
