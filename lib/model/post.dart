



class PostList{
  final List<Post> posts;

  PostList(this.posts);

  factory PostList.fromJson(List<dynamic> parsedJson){
    // List<Post> posts = new List<Post>();
    List<Post> posts = <Post>[];
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();
    return new PostList(posts);
  }

}




class Post{
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']
    );
  }

}