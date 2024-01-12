import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../resources/colors.dart';

class ShowsListView extends StatefulWidget {
  const ShowsListView({super.key});

  @override
  State<ShowsListView> createState() => _ShowsListViewState();
}

class _ShowsListViewState extends State<ShowsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _buildShowTicketItem();
      },
      separatorBuilder: (context, index) {
        return Container(height: 5, color: AppColors.grey);
      },
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
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
                    child: Assets.images.png.slide2.image(
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
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
