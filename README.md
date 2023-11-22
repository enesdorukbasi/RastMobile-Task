# RastMobile-Task
Yalnız mobil uygulama kodlayacağım için veritabanı olarak SQLite kullandım.</br>
Uygulama içerisinde State için Bloc ve GetX kullandım. Bloc ile veritabanı ile veri alışverişi sağladım, diğer state işlemleri içinse GetX kullandım.

Task ile ilgili sormak istediğiniz ve ya düzeltmemi istediğiniz bir kısım olursa lütfen benimle iletişime geçin.

Projeden anladığım;
-Projenin amacı içerisinde board adındaki işlerin oluşturulup içerisinde task oluşturularak görev dağılımı yapılmasına olana sağlayan bir uygulama. Tasarımda board tasarımının bulunmamış olmasından kaynaklı olarak bu kısmı es geçtim ve diğer kısımları kodladım.
-Uygulamada bulunan ayarlar butonu hariç tüm butonlar aktif olarak bir işleve sahip.
-Search butonu animasyonlu olarak topbarda bir textbox çıkarıyor ve burada yapılan aramalara göre ekrana liste geliyor.
-Bottombarda ki home tuşu ana ekrana götürürken, "Go to Word Ninja" butonu ise Google Play ve ya AppStore üzerinden uygulamayı açıyor.

Kodlarken sırasıyla ilerlediğim adımlar;
-Uygulamanın klasör yapısını hazırladıktan sonra genel olarak her geliştirdiğim projede ihtiyacını duyduğum extensions vesaire gibi hazırlıkları yaptım.
-Figmada bulunan tasarım üzerinden ilerleyerek ui'ını tamamladım.
-Navigation işlemleri için go_router paketini seçtim ve bu paket için kodlamalarımı yaptım.
-Kullanacağım veritabanı olarak SQLite'ı seçmemin ardından modeller ve veritabanı servislerini hazırladım.
-State Managements olarak Bloc ve GetX ile ilerleme kararı aldım ve gerekli olan ayarlamaları yaptım, daha sonrasında test ettim.
-CacheManager kodlamasını yaptım.

Mimari hakkında;
-Daha düzenli bir kod için DependencyInjector içerisinde bloclarımı tanımlarım ve bu blocları liste içerisine alarak main.dart içerisinde MultiBlocProvider içerisinde bunu kullanırım. Bu uygulamada bir adet bloc kullanmış olmama rağmen bunu gösterebilmek için aynı şekilde yaptım.
-Interface mantığını servis içerisinde uyguladım.
-BaseFunctions veya RouteManager gibi sınıflarımı genellikle ihtiyacım olduğunda kullanabilmek için BaseSingleton adında ki bir mixin içerisinde get ediyorum.
