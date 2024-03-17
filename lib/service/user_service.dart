import '../model/user_model.dart';
import 'iservice.dart';

class UserService implements Iservice<User> {
  Future<User> getUserTest() async {
    await Future.delayed(Duration(seconds: 1));
    return User(
      id: 1,
      username: 'user',
      password: 'password',
      created_at: DateTime.now(),
      status: true,
    );
  }

  @override
  Future<User> create(User s) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<User> getOne(int id) async {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<List<User>> search(String query) async {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<User> update(User s) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
