import 'package:flutter/material.dart';
import 'package:movies_mage/features/homepage/presentaion/views/search_srceen/presentaion/views/category_search/custom_search_chips.dart';
import 'package:movies_mage/features/homepage/presentaion/views/search_srceen/presentaion/views/category_search/movies_category_search_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/search_srceen/presentaion/views/category_search/tv_category_search_listview.dart';


class SearchChipsListView extends StatelessWidget {
  const SearchChipsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Movie",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              CustomSearchChips(
                category: "Action",
                color: Color(0xff104092), // ✅ const already applied
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Action",
                        categoryId: 28,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Adventure",
                color: Color(0xff0C47A1),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Adventure",
                        categoryId: 12,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Animation",
                color: Color(0xff1665C1),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Animation",
                        categoryId: 16,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Comedy",
                color: Color(0xff1776D2),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Comedy",
                        categoryId: 35,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Crime",
                color: Color(0xff2188E4),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Crime",
                        categoryId: 80,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Horror",
                color: Color(0xff1F98F5),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Horror",
                        categoryId: 27,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Drama",
                color: Color(0xff42A5F6),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Drama",
                        categoryId: 18,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "War",
                color: Color(0xff64B5F4),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "War",
                        categoryId: 10752,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Fantasy",
                color: Color(0xff7EB6F6),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Fantasy",
                        categoryId: 14,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "History",
                color: Color(0xff9CCEF9),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "History",
                        categoryId: 36,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Romance",
                color: Color(0xffC8E6FA),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoviesCategorySearchListview(
                        categoryName: "Romance",
                        categoryId: 10749,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Tv Show",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              CustomSearchChips(
                category: "Action",
                color: Color(0xff104092),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Action",
                        categoryId: 10759,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Mystery",
                color: Color(0xff0C47A1),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Mystery",
                        categoryId: 9648,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Family",
                color: Color(0xff1665C1),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Family",
                        categoryId: 10751,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Animation",
                color: Color(0xff1776D2),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Animation",
                        categoryId: 16,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Comedy",
                color: Color(0xff2188E4),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Comedy",
                        categoryId: 35,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Crime",
                color: Color(0xff1F98F5),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Crime",
                        categoryId: 80,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Sci-fi & Fantasy",
                color: Color(0xff42A5F6),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Sci-fi & Fantasy",
                        categoryId: 10765,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Drama",
                color: Color(0xff64B5F4),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Drama",
                        categoryId: 18,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Documentary",
                color: Color(0xff7EB6F6),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Documentary",
                        categoryId: 99,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Western",
                color: Color(0xff9CCEF9),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Western",
                        categoryId: 37,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              CustomSearchChips(
                category: "Romance",
                color: Color(0xffC8E6FA),
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TvCategorySearchListview(
                        categoryName: "Romance",
                        categoryId: 10749,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
