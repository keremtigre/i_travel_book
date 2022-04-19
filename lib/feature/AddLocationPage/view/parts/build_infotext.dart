part of addlocation_view.dart;

class _BuildInfoText extends StatelessWidget {
  _BuildInfoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isdarkmode = snapshot.data;
            Color settingDrawerColor =
                isdarkmode! ? AppColor().appColor : Colors.white;
            return Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 2,
                      color: !isdarkmode ? AppColor().appColor : Colors.white),
                  color: Colors.white.withOpacity(0.6),
                ),
                height: context.height / 10,
                width: context.width / 2,
                child: Text(
                  "Seçmek istediğiniz konumun üzerine birkaç saniye basılı tutunuz",
                  style: TextStyle(color: Colors.black),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
