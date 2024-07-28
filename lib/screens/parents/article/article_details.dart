import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:dio/dio.dart';

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
  int commentCount = 0;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    likeCount = widget.likeList.length;
    commentCount = widget.commentList.length;
    liked = widget.likeList.any((like) => like.user?.id == ctrl.user.value.id);
  }

  Future<void> postLike(LikeModel likeModel) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    try {
      final response = await DioService().post(
          "/likes?userId=${likeModel.user?.id}&articleId=${likeModel.articleId}");
      if (response.statusCode == 201) {
        setState(() {
          liked = !liked;
          likeCount = liked ? likeCount + 1 : likeCount - 1;
          if (liked) {
            widget.likeList.add(likeModel);
          } else {
            widget.likeList
                .removeWhere((like) => like.user?.id == likeModel.user?.id);
          }
        });
        EasyLoading.dismiss();
      } else {
        setState(() {
          liked = !liked;
          likeCount = liked ? likeCount + 1 : likeCount - 1;
          if (liked) {
            widget.likeList.add(likeModel);
          } else {
            widget.likeList
                .removeWhere((like) => like.user?.id == likeModel.user?.id);
          }
        });
        EasyLoading.dismiss();
      }
    } catch (e) {
      setState(() {
        liked = !liked;
        likeCount = liked ? likeCount + 1 : likeCount - 1;
        if (liked) {
          widget.likeList.add(likeModel);
        } else {
          widget.likeList
              .removeWhere((like) => like.user?.id == likeModel.user?.id);
        }
      });
      EasyLoading.dismiss();
    }
  }

  Future<void> postComment(CommentModel commentModel) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    try {
      final response = await DioService().post(
          "/comments?content=${commentModel.content}&articleId=${commentModel.articleId}");
      if (response.statusCode == 201) {
        setState(() {
          commentCount += 1;
          widget.commentList;
        });

        EasyLoading.dismiss();
      } else {
        print('Error create');
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
      body: Stack(

          children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
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
                height: 10,
              ),
              widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? GridView.builder(
                      padding: EdgeInsets.all(5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
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
                          text: '$commentCount ',
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
                    icon: Icon(Icons.thumb_up_outlined,
                        color: liked ? Colors.blue : Colors.black),
                    onPressed: () {
                      LikeModel likeSubmit = LikeModel(articleId: widget.id);

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
                    onPressed: () {
                      // Share functionality here
                    },
                    label: Text("Share"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Tất cả bình luận",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.commentList.length,
                  itemBuilder: (context, index) {
                    final comment = widget.commentList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage(comment.user!.userDetail.first.avatar),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(comment.user?.userDetail.first.fullName()),
                      subtitle: Text(comment.content ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomAppBar(
            height: 70,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    // Handle camera action
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintStyle:
                          TextStyle(color: Colors.grey[800], fontSize: 13),
                      hintText: "Thêm bình luận ...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.gif),
                  onPressed: () {
                    // Handle GIF action
                  },
                ),
                IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    CommentModel comment = CommentModel(
                        articleId: widget.id, content: commentController.text);

                    postComment(comment);
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
