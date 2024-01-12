import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../resources/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'DISCOVER SHOWS',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              _buildTextField(),
              _buildBanner(),
              _buildListShows(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBorderTextField() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.transparent));
  }

  _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Tỉnh thành tổ chức, ban nhạc tổ chức',
            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey),
            prefixIconConstraints: BoxConstraints(maxHeight: 32, maxWidth: 48),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Assets.images.svg.iconSearchInactive.svg(width: 32, height: 32),
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 32, maxWidth: 48),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Assets.images.svg.iconFilterInactive.svg(width: 24, height: 24),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            isDense: true,
            border: _buildBorderTextField(),
            enabledBorder: _buildBorderTextField(),
            focusedBorder: _buildBorderTextField(),
            filled: true,
            fillColor: AppColors.neutral),
      ),
    );
  }

  _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sắp diễn ra',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              )
            ],
          ),
          CarouselSlider(
              items: [
                buildBannerItem(),
                buildBannerItem(),
                buildBannerItem(),
                buildBannerItem(),
              ],
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                disableCenter: true,
                pageSnapping: false,
                padEnds: false,
                scrollDirection: Axis.horizontal,
              ))
        ],
      ),
    );
  }

  buildBannerItem() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: Assets.images.png.slide1.provider(), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.grey.withOpacity(0.7),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '24/3/2022 | 19:30 - 24:00 PM',
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Bức Tường Band',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Nhà Hát Lớn Hà Nội',
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    'Đặt Vé',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildListShows() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildShowTicketItem();
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 5,
            color: AppColors.grey,
          );
        },
        itemCount: 5,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true);
  }

  _buildShowTicketItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Assets.images.png.slide2.image(width: 32, height: 32, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '1900 LE THEATRE HANOI',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                'Response',
                style: TextStyle(fontSize: 14, color: AppColors.grey),
              )
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Assets.images.png.slide1.image(fit: BoxFit.cover)),
          ),
          SizedBox(height: 12),
          Text(
            "1900 Buffet Drink Ladies's Night",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Đến hẹn lại lên, ngày thứ 3 MIỄN PHÍ VÉ VÀO CỬA cho các nàng tại 1900. Cùng đến và UỐNG COCKTAIL THOẢI MÁI TẠI QUẦY BAR, chỉ có tại nhà",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            color: AppColors.grey,
            height: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: AppColors.neutralText,
                size: 16,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Nhà hát lớn Hà Nội',
                  style: TextStyle(fontSize: 12, color: AppColors.neutralText),
                ),
              ),
              Text(
                'Discount for 2',
                style: TextStyle(fontSize: 12, color: AppColors.neutralText),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_sharp,
                color: AppColors.neutralText,
                size: 16,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '19:30 - 24:00 PM',
                  style: TextStyle(fontSize: 12, color: AppColors.neutralText),
                ),
              ),
              Assets.images.svg.iconTicketPrimaryActive.svg(width: 20, height: 20),
              SizedBox(width: 4),
              Text(
                '360,000 VND',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: AppColors.neutralText,
                size: 16,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '24/312022',
                  style: TextStyle(fontSize: 12, color: AppColors.neutralText),
                ),
              ),
              Text(
                '430,000 VND',
                style: TextStyle(fontSize: 12, color: AppColors.neutralText, decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.svg.iconShopActive.svg(width: 20, height: 20, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Đặt vé ngay',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.svg.iconFavouritePrimaryActive.svg(width: 20, height: 20, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Thích',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
