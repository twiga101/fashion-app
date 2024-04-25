import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fashon_app/screens/search/view_model/search_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../base/base_view_model.dart';
import '../../../data/app_data.dart';
import '../../../utils/constants.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    final viewModel = ref.watch(searchViewModelProvider);
    if (viewModel.isFirstTry) {
      viewModel.isFirstTry = false;
      itemSearchList = mainList;
    }
  
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 50),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.07,
                child: TextField(
                  onChanged: (value) {
                    viewModel.searchFunction(value);
                  },
                  controller: viewModel.getSearchTextContrrollerValue(),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Casual",
                    hintStyle: textTheme.headline3?.copyWith(
                        color: Colors.grey[600], fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.clearSearchTextField();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  style: textTheme.headline3
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Expanded(
            child: itemSearchList.isNotEmpty
                ? searchItem(size, textTheme, true)
                : viewModel.getSearchTextContrrollerValue().text.isEmpty
                    ? searchItem(size, textTheme, false)
                    : Column(
                        children: [
                          const Image(
                            image: AssetImage("assets/images/search_fail.png"),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            child: FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: const Text(
                                "No Resualt found :(",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
          )
        ],
      ),
    );
  }

  GridView searchItem(Size size, TextTheme textTheme, bool isFromSearch) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.80),
      itemCount: isFromSearch ? itemSearchList.length : mainList.length,
      itemBuilder: (ctx, index) {
        BaseViewModelOffline current =
            isFromSearch ? itemSearchList[index] : mainList[index];
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size.height * 0.02,
                left: size.width * 0.01,
                right: size.width * 0.01,
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.28,
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
              ),
              Positioned(
                bottom: size.height * 0.04,
                child: Text(
                  current.name,
                  style: textTheme.headline2,
                ),
              ),
              Positioned(
                bottom: size.height * 0.01,
                child: RichText(
                  text: TextSpan(
                    text: "€",
                    style: textTheme.subtitle2?.copyWith(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: current.price.toString(),
                        style: textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  top: size.height * 0.01,
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        LineIcons.addToShoppingCart,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
