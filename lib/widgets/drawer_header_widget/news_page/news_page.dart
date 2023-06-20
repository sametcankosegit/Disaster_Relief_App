import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/colors.dart';
import 'news_item.dart';

class NewsPage extends StatelessWidget {
  final List<NewsItem> newsList = [
    NewsItem(
      title:
          'İzmirde Hak Sahibi Afetzedelere Konut Teslim Çalışmaları Devam Ediyor',
      image: 'assets/images/gundem1.jpeg',
      description:
          'Ege Denizinde Seferihisarda meydana gelen 6,6 büyüklüğündeki deprem sonrası hak sahiplerine konut ve iş yeri teslimi çalışmaları devam ediyor.',
      moreInfo:
          'https://www.afad.gov.tr/izmirde-hak-sahibi-afetzedelere-konut-teslim-calismalari-devam-ediyor',
    ),
    NewsItem(
      title:
          'Kahramanmaraş Depremlerini Oluşturan Fayların 3 Boyutlu Haritaları Çıkarılıyor',
      image: 'assets/images/gundem2.jpeg',
      description:
          'Afet ve acil durumlar konusunda verilen eğitimlerle; toplumda farkındalık oluşturmak, afetleri başa çıkılabilir bir olguya dönüştürmek ve yeterlilik bilincinin toplumun tüm kesimine yerleştirilmesini sağlamak amacıyla ‘Afete Hazır Türkiye Bilinçlendirme ve Eğitim Projesi’ başlatılmıştı. 2018 itibariyle proje kapsamında 10 milyondan fazla kişiye ulaşıldı. ',
      moreInfo:
          'https://www.afad.gov.tr/kahramanmaras-depremlerini-olusturan-faylarin-3-boyutlu-haritalari-cikariliyor',
    ),
    NewsItem(
        title: 'Van’da Çığ Sempozyumu Gerçekleştirildi',
        image: 'assets/images/gundem3.jpg',
        description:
            'Çığ afetini farklı açılardan ele alıp, konunun uzmanları ve karar vericiler ile değerlendirmeyi hedefleyen Çığ Sempozyumu; Afet ve Acil Durum Yönetimi Başkanlığı, Ankara Üniversitesi ve Van İl Afet ve Acil Durum Müdürlüğü iş birliği ile 2 Şubat 2023 tarihinde Van’da düzenlendi.',
        moreInfo:
            'https://www.afad.gov.tr/vanda-cig-sempozyumu-gerceklestirildi'),
    NewsItem(
        title: 'Malatya ve Elazığ İl AFAD Müdürlüklerine Ziyaret',
        image: 'assets/images/gundem4.jpg',
        description:
            'AFAD Deprem ve Risk Azaltma Genel Müdürü Sn. Prof. Dr. Orhan Tatar, Sivil Toplumla İlişkiler ve Akreditasyon Daire Başkanı Sn. Abdülkadir Tezcan ve Risk Azaltma Planları Daire Başkanı Sn. Aslan Mehmet Coşkun, Malatya Valisi Sn. Hulusi Şahin’i ve Malatya İl Afet ve Acil Durum Müdürlüğümüzü ziyaret ederek çalışmalar hakkında brifing aldı.',
        moreInfo:
            'https://www.afad.gov.tr/malatya-ve-elazig-il-afad-mudurluklerine-ziyaret'),
    NewsItem(
        title: 'Mersin’de KBRN Tatbikatı Yapıldı',
        image: 'assets/images/gundem5.jpeg',
        description:
            'Afet Tatbikat Yılı kapsamında; İçişleri Bakanlığı Afet ve Acil Durum Yönetimi Başkanlığı ile Enerji ve Tabii Kaynaklar Bakanlığı Nükleer Düzenleme Kurumu iş birliği ile 28.12.2022 tarihinde Mersin İlinin Silifke ve Gülnar İlçeleri’nde KBRN Tatbikatı gerçekleştirildi. Tatbikata 15 Afet Grubu’nda yer alan; İçişleri Bakanlığı, Enerji ve Tabii Kaynaklar Bakanlığı, Sağlık Bakanlığı, Tarım ve Orman Bakanlığı, AFAD, Jandarma Komutanlığı, Emniyet Genel Müdürlüğü, Sahil Güvenlik Komutanlığı, Meteoroloji, Mersin Valiliği, Nükleer Düzenleme Kurumu, UMKE, Türk Kızılay, TENMAK ve Akkuyu Nükleer İşletmesi katıldı.',
        moreInfo: 'https://www.afad.gov.tr/mersinde-kbrn-tatbikati-yapildi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gündem'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 192, 129, 252),
                Color.fromARGB(255, 216, 101, 130),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(newsList[index]),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 245, 255),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Image.asset(
                        newsList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    newsList[index].title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  NewsDetailPage(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: const Text(
          'GÜNDEM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 192, 129, 252),
                Color.fromARGB(255, 216, 101, 130),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 245, 255),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    news.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 225, 228),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      news.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        launch(news.moreInfo.toString());
                      },
                      child: const Text(
                        'Daha fazla bilgi',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
