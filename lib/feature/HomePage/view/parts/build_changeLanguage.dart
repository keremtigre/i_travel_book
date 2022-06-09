part of home_view.dart;

class changeLanguage extends StatelessWidget {
  changeLanguage({
    Key? key,
    required this.isdarkmode,
  }) : super(key: key);
  final isdarkmode;

  @override
  Widget build(BuildContext context) {
    Color changeLanguageColor =
        !isdarkmode! ? AppColor().appColor : Colors.white;
    return FutureBuilder<String>(
        future: getString("language"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String language = snapshot.data!;
            return AlertDialog(
              title: Text(language == "TR"
                  ? "Uygulama Dilini Değiştir"
                  : "Change Application Language"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(language == "TR"
                      ? "Lütfen Uygulama dilini Seçiniz"
                      : "Please Select Application language"),
                  Padding(
                    padding: EdgeInsets.only(top: context.height / 50),
                    child: Container(
                      alignment: Alignment.center,
                      width: context.width / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: changeLanguageColor, width: 3)),
                      child: DropdownButton<String>(
                          alignment: Alignment.center,
                          borderRadius: BorderRadius.circular(20),
                          focusNode: FocusNode(),
                          value: context.read<HomeCubit>().selectedLanguage,
                          items: [
                            DropdownMenuItem(
                              value: "TR",
                              child: Text("Türkçe"),
                            ),
                            DropdownMenuItem(
                              value: "EN",
                              child: Text("English"),
                            )
                          ],
                          onChanged: (value) {
                            context
                                .read<HomeCubit>()
                                .setSelectedLanguage(value!);
                          }),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          language == "TR" ? "İptal" : "Cancel",
                          style: TextStyle(color: changeLanguageColor),
                        )),
                    TextButton(
                        onPressed: () async {
                          await context.read<HomeCubit>().saveLanguage(context);
                        },
                        child: Text(language == "TR" ? "Değiştir" : "Change",
                            style: TextStyle(color: changeLanguageColor)))
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
