part of locations_view.dart;

class DetailPage extends StatelessWidget {
  const DetailPage(
      {Key? key,
      required this.aciklama,
      required this.baslik,
      required this.language,
      required this.image_url})
      : super(key: key);
  final String aciklama;
  final language;
  final String baslik;
  final String image_url;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( language=="TR" ?  "Konum Detayları" : "Location Details"),
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2)),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image_url.isEmpty
                        ? Image.asset("assets/images/signup.png")
                        : Image.network(
                            image_url,
                            filterQuality: FilterQuality.high,
                            width: context.width,
                            height: context.height / 4,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor().appColor, width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                       language=="TR" ? "Başlık:" : "Title:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(baslik),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor().appColor, width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                         language=="TR" ? "Açıklama:": "Text:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(aciklama),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => (Navigator.pop(context)),
            child: Text(
              "Tamam",
              style: TextStyle(
                color: Color.fromRGBO(108, 99, 255, 1),
              ),
            ))
      ],
    );
  }
}
