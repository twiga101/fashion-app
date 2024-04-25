import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fashon_app/data/app_data.dart';
 import 'package:fashon_app/model/categories_model.dart';
import 'package:fashon_app/utils/constants.dart';
 
import '../../../base/base_view_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 2, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Find your",
                            style: theme.headline1,
                            children: [
                              TextSpan(
                                text: "Style",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        color: primaryColor, fontSize: 45),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Shine with our ",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(color: Colors.black, fontSize: 16),
                            children: const [
                              TextSpan(
                                text: "suggestions :)",
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 45),
                  child: Container(
                    margin: const EdgeInsets.only(top: 7),
                    width: size.width,
                    height: size.height * 0.17,
                    child: ListView.builder(
                      itemCount: categories.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        CategoriesModel categoryItem = categories[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage(categoryItem.imageUrl),
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              Text(
                                categoryItem.title,
                                style: theme.subtitle1,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 550),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: size.width,
                    height: size.height * 0.49,
                    child: PageView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: mainList.length,
                      itemBuilder: (context, index) {
                        return view(index, theme, size);
                      },
                    ),
                  ),
                ),
                FadeInUp(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Popular",
                          style: theme.headline3,
                        ),
                        Text("See all", style: theme.headline4)
                      ],
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 750),
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.44,
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.63),
                        itemCount: mainList.length,
                        itemBuilder: (ctx, index) {
                          BaseViewModelOffline current = mainList[index];
                          return Column(
                            children: [
                              Container(
                                width: size.width * 0.5,
                                height: size.height * 0.3,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: AssetImage(current.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  current.name,
                                  style: theme.headline2,
                                ),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "€",
                                      style: theme.subtitle2?.copyWith(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    TextSpan(
                                      text: current.price.toString(),
                                      style: theme.subtitle2?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ])),
                            ],
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget view(int index, TextTheme theme, Size size) {
    print("test");
    return AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }

          return Transform.rotate(
            angle: (3.14) * value,
            child: _buildCard(size, mainList[index], theme, context),
          );
        });
  }

  Padding _buildCard(
      Size size, BaseViewModelOffline data, TextTheme theme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            width: size.width * 0.6,
            height: size.height * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                  image: AssetImage(data.imageUrl), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              data.name,
              style: theme.headline2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "s",
              style: theme.subtitle2?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
