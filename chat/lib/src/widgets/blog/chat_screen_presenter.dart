import 'package:chat/src/data/database_helper.dart';
import 'package:chat/src/data/rest_ds.dart';
import 'package:chat/src/models/blog.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

abstract class ChatScreenContract {
  void onLoadBlogSuccess(ListBlog blogs);
  void onLoadBlogError(String errorMessage);
  void onLogoutSuccess();
}

class ChatScreenPresenter {
  ChatScreenContract _view;
  RestDatasource api = new RestDatasource();
  ChatScreenPresenter(this._view);
  int current_page = 0;
  loadBlogs() {
    print('Loading: ${current_page + 1}');

    api.getBlogs(current_page + 1).then((ListBlog blogs) {
      if (current_page < blogs.total_pages) {
        current_page++;
      }

      updateBadger();
      _view.onLoadBlogSuccess(blogs);
    }).catchError(
        (Exception error) => _view.onLoadBlogError(error.toString()));
  }

  void logout() {
    api.logout().then((dynamic _) {
      var db = new DatabaseHelper();
      db.deleteDb().then((_) {
        _view.onLogoutSuccess();
      });
    });
  }

  void readAll() {
    api.readAll().then((dynamic _) {
      updateBadger();
    });
  }

  void updateBadger() {
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) FlutterAppBadger.removeBadge();
      // FlutterAppBadger.updateBadgeCount(1);
    });
  }
}
