part of locations_view.dart;

class _searchText extends StatelessWidget {
  _searchText({
    Key? key,
    required this.isdarkmode,
    required this.snapshot,
  }) : super(key: key);

  final bool isdarkmode;
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.width / 40),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: context.read<LocationsCubit>().searchController,
              onChanged: (value) {
                context.read<LocationsCubit>().searchLocation(snapshot);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white.withOpacity(0.6),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: AppColor().appColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor().appColor,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor().appColor,
                    )),
                hintText: "Aramak istediğiniz konum",
                prefixText: ' ',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor().appColor),
            child: TextButton(
                onPressed: () {
                  if (!context
                      .read<LocationsCubit>()
                      .searchController
                      .text
                      .isEmpty) {
                    context.read<LocationsCubit>().searchLocation(snapshot);
                  }
                  FocusScope.of(context).unfocus();
                },
                child: AutoSizeText(
                  "Ara",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
