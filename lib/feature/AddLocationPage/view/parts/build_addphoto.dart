part of addlocation_view.dart;

class _BuildAddPhotoWidget extends StatelessWidget {
  const _BuildAddPhotoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.read<AddlocationCubit>().image == null
              ? "Fotoğraf ekleyebilirsiniz"
              : "Fotoğraf Eklendi",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: context.height / 100,
        ),
        InkWell(
            onTap: (() {
              
              FocusScope.of(context)
                  .requestFocus(FocusNode());
              context
                  .read<AddlocationCubit>()
                  .pickImage(context);
              debugPrint(context
                  .read<AddlocationCubit>()
                  .image
                  .toString()); 
            }),
            child: context.read<AddlocationCubit>().image == null
                ? Container(
                    width: context.width / 3,
                    height: context.height / 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor().appColor, width: 5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AddPhotoAnimation())
                : Container(
                    width: context.width / 3,
                    height: context.height / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        context.read<AddlocationCubit>().image!,
                        fit: BoxFit.cover,
                      ),
                    ))),
      ],
    );
  }
}