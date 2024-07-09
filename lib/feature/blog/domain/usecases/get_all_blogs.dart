import 'package:fpdart/fpdart.dart';
import 'package:tuncblog/core/error/failure.dart';
import 'package:tuncblog/core/usecases/usecase.dart';
import 'package:tuncblog/feature/blog/domain/entities/blog.dart';
import 'package:tuncblog/feature/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
