import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncblog/core/theme/color_palette.dart';
import 'package:tuncblog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:tuncblog/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:tuncblog/feature/blog/presentation/pages/add_new_blog_page.dart';
import 'package:tuncblog/feature/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            tooltip: "Sign Out",
            onPressed: () async {
              context.read<AuthBloc>().add(AuthSignOut());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            tooltip: "Delete",
            onPressed: () async {
              context.read<AuthBloc>().add(AuthDeleted());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Auth Failed: ${state.error}"),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? ColorPalette.gradient1
                      : ColorPalette.gradient2,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
