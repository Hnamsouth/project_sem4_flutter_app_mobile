import 'package:flutter/material.dart';

class ArticleDetails extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String content;

  const ArticleDetails({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    super.key,
  });

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  int likeCount = 0;
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();
  final List<String> comments = [];

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Text("Author's name"), // Replace with actual author if available
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("This is Title", style: TextStyle(fontSize: 20)),
              subtitle: Text("This is subtitle"),
            ),
            SizedBox(
              height: 15,
            ),
            Image.network(widget.imageUrl),
            SizedBox(
              height: 10,
            ),
            Text(widget.content),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: isLiked ? Colors.blue : Colors.black,
                  ),
                  onPressed: toggleLike,
                ),
                Text('$likeCount likes'),
              ],
            ),
            Divider(),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      addComment(_commentController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
