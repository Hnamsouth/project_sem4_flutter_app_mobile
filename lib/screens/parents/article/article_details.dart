
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;

import '../../../controller/user_controller.dart';
import '../../../model/action/article_model.dart';
import '../../../service/api_service.dart';

final UserController ctrl = Get.find();

class ArticleDetails extends StatefulWidget {
  final int? id;
  final String? title;
  final List<String>? imageUrl;
  final String? content;
  final DateTime? createdAt;
  final List<LikeModel> likeList;
  final List<CommentModel> commentList;

  const ArticleDetails({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    super.key,
    required this.createdAt,
    required this.likeList,
    required this.commentList,
  });

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  bool liked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    // Initial state
    likeCount = widget.likeList.length;
    liked = widget.likeList.contains(1); // Check if the user has liked already
  }

  Future<void> postLike(LikeModel likeModel) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    try {
      final response = await DioService()
          .post("/likes", data: likeModel);
      if (response.statusCode == 201) {
        setState(() {
          liked = !liked;
          likeCount = liked ? likeCount + 1 : likeCount - 1;
          if (liked) {
            widget.likeList.add(likeModel);
          } else {
            widget.likeList.remove(likeModel);
          }
        });
        EasyLoading.dismiss();
      } else {
        print('Failed to submit like: ${response.statusCode}');
        EasyLoading.dismiss();
      }
    } catch (e) {
      print('Error occurred: $e');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.title ?? '', style: TextStyle(fontSize: 20)),
              subtitle: Text(intl.DateFormat('EEEE, dd/MM/yyyy', 'vi_VN')
                  .format(widget.createdAt ?? DateTime.now())),
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.content ?? ''),
            SizedBox(
              height: 20,
            ),
            widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust the number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: widget.imageUrl!.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.imageUrl![index],
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                  label: Text('$likeCount'),
                ),
                TextButton(
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: '${widget.commentList.length} ',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'comments'),
                        ],
                      ),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    LikeModel likeSubmit = LikeModel(
                        userId: ctrl.user.value.id, articleId: widget.id);

                    postLike(likeSubmit);
                  },
                  label: Text("Likes"),
                ),
                TextButton.icon(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                  label: Text("Comment"),
                ),
                TextButton.icon(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                  label: Text("Share"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
