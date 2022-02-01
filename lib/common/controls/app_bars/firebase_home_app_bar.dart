import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class FirebaseHomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const FirebaseHomeAppBar({
    Key? key,
    required this.title,
    required this.addAction,
    required this.uploadAction,
    required this.changeApi,
    required this.disableUpload,
    required this.realApi,
  }) : super(key: key);

  final String title;
  final bool disableUpload;
  final bool realApi;
  final Function() addAction;
  final Function() uploadAction;
  final Function() changeApi;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyles.appBarTitle),
          const Spacer(),
          IconButton(
            icon: Icon(realApi ? Icons.account_tree : Icons.account_tree_outlined),
            onPressed: () => changeApi(),
          ),
          IconButton(
            icon: Icon(disableUpload ? Icons.cloud_upload_outlined : Icons.cloud_upload),
            onPressed: () => disableUpload ? null : uploadAction(),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () => addAction(),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
