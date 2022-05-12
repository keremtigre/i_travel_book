part of locations_view.dart;

class _searchText extends StatelessWidget {
  _searchText({
    Key? key,
    required this.isdarkmode,
    required this.snapshot,
    required this.language
  }) : super(key: key);
  final language;
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
                context.read<LocationsCubit>().searchLocations(snapshot);
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
                hintText:language=="TR" ? "Aramak istediğiniz konumun başlığı" :"Title of the location you want to search",
                prefixText: ' ',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
