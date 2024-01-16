import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/food_item.dart';

import 'bloc/card_list_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => CartListBloc())],
      dependencies: [],
      child: const MaterialApp(
        title: "Food Delivery",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              FirstHalf(),
              const SizedBox(
                height: 45,
              ),
              for (var foodItem in foodItemList.foodItems)
                ItemContainer(foodItem: foodItem)
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  ItemContainer({super.key, required this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem, BuildContext context) {
    bloc.addToList(foodItem);
    final snackBar = SnackBar(
      content: Text("${foodItem.title} has been added to the cart"),
      duration: const Duration(milliseconds: 1000),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem, context);
      },
      child: Items(
          hotel: foodItem.hotel,
          itemName: foodItem.title,
          itemPrice: foodItem.price,
          imgUrl: foodItem.imgUrl,
          leftAligned: foodItem.id % 2 == 0 ? true : false),
    );
  }
}

class Items extends StatelessWidget {
  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final String hotel;
  final double itemPrice;

  const Items({
    super.key,
    required this.leftAligned,
    required this.imgUrl,
    required this.itemName,
    required this.itemPrice,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? const Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : const Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              itemName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            )),
                        Text(
                          "\$$itemPrice",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black45, fontSize: 15),
                          children: [
                            const TextSpan(text: "by "),
                            TextSpan(
                              text: hotel,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: containerPadding,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class FirstHalf extends StatelessWidget {
  const FirstHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: [
          CustomAppBar(),
          const SizedBox(height: 30),
          title(),
          const SizedBox(
            height: 30,
          ),
          searchBar(),
          const SizedBox(
            height: 30,
          ),
          categories()
        ],
      ),
    );
  }

  Widget categories() {
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryListItem(
              categoryIcon: Icons.bug_report,
              categoryName: "Burgers",
              availability: 12,
              selected: true),
          CategoryListItem(
              categoryIcon: Icons.bug_report,
              categoryName: "Pizza",
              availability: 12,
              selected: false),
          CategoryListItem(
              categoryIcon: Icons.bug_report,
              categoryName: "Rolls",
              availability: 12,
              selected: false),
          CategoryListItem(
              categoryIcon: Icons.bug_report,
              categoryName: "Burgers",
              availability: 12,
              selected: false),
          CategoryListItem(
              categoryIcon: Icons.bug_report,
              categoryName: "Burgers",
              availability: 12,
              selected: false),
        ],
      ),
    );
  }

  Widget searchBar() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search..",
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintStyle: TextStyle(color: Colors.black87)),
            ))
      ],
    );
  }

  Widget title() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 45,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Food",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
            Text(
              "Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu),
          StreamBuilder(
              stream: bloc.listStream,
              builder: (context, snapShot) {
                List<FoodItem>? foodItems = snapShot.data;
                int length = foodItems != null ? foodItems.length : 0;
                return buildGestureDetector(length, context, foodItems);
              }),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(int length, BuildContext context,
      List<FoodItem>? foodItems) {
    return GestureDetector(
      onTap: () {
        if(length>0){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> Cart())
          );
        }else{
          return;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(length.toString()),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  const CategoryListItem({super.key,
    required this.categoryIcon,
    required this.categoryName,
    required this.availability,
    required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: selected ? const Color(0xfffeb324) : Colors.white,
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 15,
                offset: const Offset(25, 0),
                spreadRadius: 15)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey,
                    width: 1.5)),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            categoryName,
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black),
          )
        ],
      ),
    );
  }
}
