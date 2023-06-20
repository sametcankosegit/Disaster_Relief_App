import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/colors.dart';
import 'activity_items.dart';

class ActivityPage extends StatelessWidget {
  final List<ActivityItem> activityList = [
    ActivityItem(
      title: 'TÜRKİYE AFET RİSK AZALTMA PLANI (TARAP)',
      image: 'assets/images/faaliyet1.jpg',
      description:
          'Türkiye Afet Risk Azaltma Planı (TARAP), 2022 ile 2030 yıllarını kapsayan, afet risklerini en azaltmak için AFAD koordinasyonunda hazırlanmış ulusal bir plandır. Bu plan, ülkemizde yaşanabilecek her tür ve ölçekteki afet için risk azaltma çalışmalarını yapacak kamu kurum ve kuruluşları, yerel yönetimler, özel sektör, sivil toplum kuruluşları, üniversiteler ve gerçek kişileri kapsamaktadır.\n TARAP ile afetlerin neden olabileceği fiziksel, sosyal, ekonomik, çevresel, psikolojik zarar ve kayıpların önlenmesi veya etkilerinin en aza indirilmesi; ayrıca dayanıklı, güvenli, hazırlıklı, sürdürülebilir, afete dirençli yaşam çevrelerin oluşturulması ve afet öncesinde hazırlanarak uygulanması gereken afet risk azaltma çalışmalarının temel prensiplerinin belirlenmesi amaçlanmaktadır.',
      moreInfo:
          'https://www.afad.gov.tr/afetler-gerceklesmeden-riskleri-azaltiyoruz',
    ),
    ActivityItem(
      title: 'Afet Eğitim İle Zihinsel Dönüşüm',
      image: 'assets/images/faaliyet2.jpg',
      description:
          'Afet ve acil durumlar konusunda verilen eğitimlerle; toplumda farkındalık oluşturmak, afetleri başa çıkılabilir bir olguya dönüştürmek ve yeterlilik bilincinin toplumun tüm kesimine yerleştirilmesini sağlamak amacıyla ‘Afete Hazır Türkiye Bilinçlendirme ve Eğitim Projesi’ başlatılmıştı. 2018 itibariyle proje kapsamında 10 milyondan fazla kişiye ulaşıldı. ',
      moreInfo: 'https://www.afad.gov.tr/afet-egitim-ile-zihinsel-donusum',
    ),
    ActivityItem(
        title: 'Her Koşulda Vatandaşlarımızın Yanındayız',
        image: 'assets/images/faaliyet3.jpg',
        description:
            '1999 yılında yaşanan Marmara Depreminde yaşanan imkansızlıklar ve koordinasyon eksikliği sonucunda üç kurumun birleştirilmesi ile 2009’da Başbakanlığa bağlı AFAD kuruldu. Cumhurbaşkanlığı Hükümet Sistemi ile ilgili yapılan düzenlemeler kapsamında, 15 Temmuz 2018 tarihinde yayınlanan 4 nolu Cumhurbaşkanlığı Kararnamesi ile Afet ve Acil Durum Yönetimi Başkanlığı İçişleri Bakanlığına bağlandı. 2011 yılında meydana gelen Van merkez ve Erciş ilçesinde meydana gelen iki büyük deprem sonrasında hızlı müdahele ve etkin koordinasyonla elde edilen sonuç, arama kurtarma hizmetlerinde profesyonel olarak yetiştirilmiş personel, çağın gereklerine uygun modern araç, gereç ve malzeme ile donatılmış ekip ve birliklerin gerekliliğini bir kez daha ortaya koydu.',
        moreInfo:
            'https://www.afad.gov.tr/her-kosulda-vatandaslarimizin-yanindayiz'),
    ActivityItem(
        title: 'Nüfus Hareketleri',
        image: 'assets/images/faaliyet4.jpg',
        description:
            'Dünyada en çok sığınmacıya ev sahipliği yapan ülkemiz, AFAD koordinasyonunda, savaştan kaçan 3 milyonu aşkın Suriyeli sığınmacıya yeni bir hayat sundu. Tüm Suriyeli sığınmacılara sağlık hizmeti imkanı sunuldu. Kayıp bir neslin oluşmaması için Suriyeli çocuklar okula kazandırıldı.',
        moreInfo: 'https://www.afad.gov.tr/nufus-hareketleri'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faaliyetlerimiz'),
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
        itemCount: activityList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityDetailPage(activityList[index]),
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
                        activityList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    activityList[index].title,
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

class ActivityDetailPage extends StatelessWidget {
  final ActivityItem activity;

  ActivityDetailPage(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: const Text('FAALİYETLERİMİZ'),
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
                    activity.image,
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
                      activity.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      activity.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        launch(activity.moreInfo.toString());
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
