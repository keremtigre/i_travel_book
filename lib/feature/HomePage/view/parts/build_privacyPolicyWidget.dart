part of home_view.dart;

class PrivacyPolicyWidget extends StatelessWidget {
  final language;
  final darkmodeSnapshot;
  const PrivacyPolicyWidget({Key? key,required this.language,required this.darkmodeSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(language == "TR" ? "Gizlilik Politikası" : "Privacy Policy"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(language == "TR"
              ? "Uygulamayı kullanmaya devam etmeniz için Gizlilik Politikamızı kabul etmeniz gerekir.ITravelBook verilerinizi başkalarıyla asla paylaşmaz."
              : "To continue using the application, you must accept our Privacy Policy. ITravelBook will never share your data with others."),
          Padding(
            padding: EdgeInsets.only(top: context.height / 50),
            child: InkWell(
              onTap: () async {
                await launchUrl(Uri.parse(
                    "https://www.freeprivacypolicy.com/live/71123d10-bc1a-43db-b45c-d8fcad645bd7"));
              },
              child: Text(
                language == "TR" ? "Gizlilik Politikamız" : "Privacy Policy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkmodeSnapshot.data!
                        ? Colors.white
                        : AppColor().appColor),
              ),
            ),
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              await CloudHelper().privacyPolicyAccepted().then((value) {
                if (value == null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context,
                        ) =>
                            HomePage(),
                      ),
                      (route) => true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Sorun oluştu: " + value.toString())));
                }
              });
            },
            child: Text(language == "TR" ? "Kabul Ediyorum" : "Accept"))
      ],
    );
  }
}
