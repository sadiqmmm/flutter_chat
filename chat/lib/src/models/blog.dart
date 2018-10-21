import 'package:chat/src/models/user.dart';

class Blog {
  int _id;  
  String _title;
  String _body;
  DateTime _created_at;
  User _user;

  Blog.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];    
    this._body = obj["body"];
    this._user = new User.map(obj["user"]);
    this._created_at = DateTime.tryParse(obj["created_at"]);
  }

  int get id => _id;
  String get title => _title;
  String get body => _body;
  DateTime get created_at => _created_at;
  User get user => _user;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = _title;
    map["body"] = _body;
    map["user"] = _user;
    map["created_at"] = _created_at;

    return map;
  }
}

class ListBlog {
  int _current_page;
  int _count;
  int _total_pages;
  int _total_count;
  List<Blog> _blogs = <Blog>[];

  int get current_page => _current_page;
  int get count => _count;
  int get total_pages => _total_pages;
  int get total_count => _total_count;
  List<Blog> get blogs => _blogs;

  ListBlog.map(dynamic obj) {
    this._current_page = obj["current_page"];
    this._count = obj["count"];
    this._total_pages = obj["total_pages"];
    this._total_count = obj["total_count"];

    for (final x in obj["blogs"]) {
      this._blogs.add(new Blog.map(x));
    }
  }
}
