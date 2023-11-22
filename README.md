# RastMobile-Task
Yalnız mobil uygulama kodlayacağım için veritabanı olarak SQLite kullandım.</br>
Uygulama içerisinde State için Bloc ve GetX kullandım. Bloc ile veritabanı ile veri alışverişi sağladım, diğer state işlemleri içinse GetX kullandım.</br></br>

Task ile ilgili sormak istediğiniz ve ya düzeltmemi istediğiniz bir kısım olursa lütfen benimle iletişime geçin.</br></br>

Projeden anladığım;</br>
-Projenin amacı içerisinde board adındaki işlerin oluşturulup içerisinde task oluşturularak görev dağılımı yapılmasına olana sağlayan bir uygulama. Tasarımda board tasarımının bulunmamış olmasından kaynaklı olarak bu kısmı es geçtim ve diğer kısımları kodladım.</br>
-Uygulamada bulunan ayarlar butonu hariç tüm butonlar aktif olarak bir işleve sahip.</br>
-Search butonu animasyonlu olarak topbarda bir textbox çıkarıyor ve burada yapılan aramalara göre ekrana liste geliyor.</br>
-Bottombarda ki home tuşu ana ekrana götürürken, "Go to Word Ninja" butonu ise Google Play ve ya AppStore üzerinden uygulamayı açıyor.</br></br>

Kodlarken sırasıyla ilerlediğim adımlar;</br>
-Uygulamanın klasör yapısını hazırladıktan sonra genel olarak her geliştirdiğim projede ihtiyacını duyduğum extensions vesaire gibi hazırlıkları yaptım.</br>
-Figmada bulunan tasarım üzerinden ilerleyerek ui'ını tamamladım.</br>
-Navigation işlemleri için go_router paketini seçtim ve bu paket için kodlamalarımı yaptım.</br>
-Kullanacağım veritabanı olarak SQLite'ı seçmemin ardından modeller ve veritabanı servislerini hazırladım.</br>
-State Managements olarak Bloc ve GetX ile ilerleme kararı aldım ve gerekli olan ayarlamaları yaptım, daha sonrasında test ettim.</br>
-CacheManager kodlamasını yaptım.</br></br>

Mimari hakkında;</br>
-Daha düzenli bir kod için DependencyInjector içerisinde bloclarımı tanımlarım ve bu blocları liste içerisine alarak main.dart içerisinde MultiBlocProvider içerisinde bunu kullanırım. Bu uygulamada bir adet bloc kullanmış olmama rağmen bunu gösterebilmek için aynı şekilde yaptım.</br>
-Interface mantığını servis içerisinde uyguladım.</br>
-BaseFunctions veya RouteManager gibi sınıflarımı genellikle ihtiyacım olduğunda kullanabilmek için BaseSingleton adında ki bir mixin içerisinde get ediyorum.</br>
