import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final title;
  final String imgUrl;

  UserProductItem({this.title, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
