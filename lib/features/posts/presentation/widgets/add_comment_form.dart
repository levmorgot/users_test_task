import 'package:flutter/material.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCommentForm extends StatelessWidget {
  final int postId;
  static final _formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final textController = TextEditingController();

  const AddCommentForm({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Как вас зовут?',
                labelText: 'Name *',
              ),
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Обязательное поле'
                    : null;
              },
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Ваш email',
                labelText: 'Email *',
              ),
              validator: (String? value) {
                return (value != null &&
                        !value.contains('@') &&
                        !value.contains('.'))
                    ? 'Невалидный email'
                    : null;
              },
            ),
            TextFormField(
              controller: textController,
              maxLines: 6,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Текст комментария',
                labelText: 'Text *',
              ),
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Обязательное поле'
                    : null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PostsCommentsListCubit>().sendPostsComment(
                        postId,
                        nameController.text,
                        emailController.text,
                        textController.text);
                    nameController.clear();
                    emailController.clear();
                    textController.clear();

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
