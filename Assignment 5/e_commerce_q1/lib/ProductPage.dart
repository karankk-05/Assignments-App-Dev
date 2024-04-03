import 'package:flutter/material.dart';
import 'Button.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatelessWidget {
  var images = [
    '1.jpeg',
    '2.jpeg',
    '11.jpeg',
    '12.jpeg',
    '3.jpeg',
    '4.jpeg',
    '5.jpeg',
    '6.jpeg',
    '7.jpeg',
    '8.jpeg',
    '9.jpeg',
    '10.jpeg',
    '13.jpeg',
    '14.jpeg'
  ];
  var names = [
    'APPLE iPhone 15 (Black, 128 GB)',
    'SAMSUNG Galaxy S23 Ultra 5G',
    'APPLE iPhone 15 (Green, 128 GB)',
    'SAMSUNG Galaxy S22 ultra 5G',
    'APPLE iPad Pro (4th Gen) ',
    'APPLE AirPods (3rd generation)',
    'APPLE Watch Ultra 2 GPS +',
    'APPLE 2023 Macbook Air Apple M2',
    'APPLE 2020 Macbook Air Apple M1',
    'SONY Alpha Mirrorless Camera with Dual Lens',
    'NIKON DSLR Camera Body with 18-140 mm Lens',
    'ASUS ROG Zephyrus Duo 16 ',
    'APPLE 2023 MacBook Pro Apple M2 Max',
    'Acer Predator (2023) Intel Core i9 13th Gen'
  ];

  var prices = [
    '73999',
    '124999',
    '73999',
    '109999',
    '79900',
    '19100',
    '89900',
    '119990',
    '83990',
    '78989',
    '86990',
    '429990',
    '290990',
    '249990'
  ];
  var details = [
    "=> 128 GB ROM \n=> 15.49 cm (6.1 inch) Super Retina XDR Display \n=> 48MP + 12MP | 12MP Front Camera \n=> A16 Bionic Chip, 6 Core Processor",
    "=> 12 GB RAM | 256 GB ROM \n=> 17.27 cm (6.8 inch) Quad HD+ Display \n=> 200MP + 10MP + 12MP + 10MP | 12MP Front Camera \n=> 5000 mAh Lithium Ion Battery",
    "=> 128 GB ROM \n=> 15.49 cm (6.1 inch) Super Retina XDR Display \n=> 48MP + 12MP | 12MP Front Camera \n=> A16 Bionic Chip, 6 Core Processor",
    "=> 12 GB RAM | 256 GB ROM \n=> 17.27 cm (6.8 inch) Display \n=> 108MP Rear Camera | 40MP Front Camera \n=> 5000 mAh Battery",
    '=> 128 GB ROM \n=> 27.94 cm (11.0 inch) Full HD Display \n=> 12 MP Primary Camera | 12 MP Front \n=> iPadOS 16 | Battery: Lithium Polymer',
    '=> With Mic:Yes \n=> Connector type: No \n=> Spatial audio with dynamic head tracking places sound all around you \n=> Adaptive EQ automatically tunes music to your ears',
    '=> The most rugged and capable. \n=> With Call Function \n=> Touchscreen \n=> Fitness & Outdoor \n=> Battery Runtime: Upto 36 hrs',
    '=> 8 GB/256 GB SSD/macOS Ventura \n=> 15.3 Inch, Space Grey, 1.51 Kg \n=> Stylish & Portable Thin and Light Laptop',
    '=> 8 GB/256 GB SSD/Mac OS Big Sur \n=> 13.3 inch, Silver, 1.29 kg \n=> Stylish & Portable Thin and Light Laptop',
    '=> Effective Pixels: 24.2 MP \n=> Sensor Type: CMOS \n=> WiFi Available \n=> UHD 4K',
    '=> Effective Pixels: 20.9 MP \n=> Sensor Type: CMOS \n=> WiFi Available \n=> UHD 4K',
    '=> AMD Ryzen 9 16 Core 7945HX \n=> 32 GB/2 TB SSD/Windows 11 Home \n=> 16 GB Graphics/NVIDIA GeForce RTX 4090 \n=> 240 HZ/175 TGP',
    '=> 32 GB/1 TB SSD macOS Ventura \n=> 14 Inch, Space Grey, 1.63 Kg \n=> Liquid Retina XDR display, 10,00,000:1 contrast ratio',
    '=> i9 13th Gen 13900HX \n=> 32 GB/1 TB SSD/Windows 11 Home12 GB Graphics/NVIDIA GeForce RTX 4080)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ProductCard(
            image: images[index],
            name: names[index],
            price: prices[index],
            details: details[index],
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String details;
  

  ProductCard({
    required this.image,
    required this.name,
    required this.price,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              height: 280,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 190,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/$image'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                formatPrice(int.parse(price)),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Wrap(
                                children: [
                                  Text(
                                    details,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 200, 0, 0),
                          child: PressableElevatedButton(
                            productName: name,
                            productImage: image,
                            productPrice: price,
                            productDetails: details,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String formatPrice(int amount) {
    final format =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
    return format.format(amount);
  }
}
