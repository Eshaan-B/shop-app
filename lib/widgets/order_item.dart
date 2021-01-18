import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd-MM-yyyy').format(widget.order.dateTime)),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.products[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${widget.order.products[index].price}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
