import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String DATABASE_NAME = 'kategori.db';
  static const int DATABASE_VERSION = 1;

  static const String TABLE_CATEGORIES = 'categories';
  static const String COLUMN_CATEGORY_ID = 'category_id';
  static const String COLUMN_CATEGORY_NAME = 'category_name';

  static const String TABLE_SUBCATEGORIES = 'subcategories';
  static const String COLUMN_SUBCATEGORY_ID = 'subcategory_id';
  static const String COLUMN_SUBCATEGORY_NAME = 'subcategory_name';
  static const String COLUMN_CATEGORY_ID_FK = 'category_id_fk';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final String dbPath = join(await getDatabasesPath(), DATABASE_NAME);
    final database = await openDatabase(dbPath,
        version: DATABASE_VERSION, onCreate: _createDB);
    return database;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_CATEGORIES (
        $COLUMN_CATEGORY_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_CATEGORY_NAME TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $TABLE_SUBCATEGORIES (
        $COLUMN_SUBCATEGORY_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_SUBCATEGORY_NAME TEXT,
        $COLUMN_CATEGORY_ID_FK INTEGER,
        FOREIGN KEY ($COLUMN_CATEGORY_ID_FK) REFERENCES $TABLE_CATEGORIES ($COLUMN_CATEGORY_ID)
      )
    ''');

    _insertCategoriesAndSubcategories(db);
  }

  void _insertCategoriesAndSubcategories(Database db) async {
    await db.transaction((txn) async {
      // Ana kategorileri ekleyin
      final mangaCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Manga'});
      final cizgiRomanCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Çizgi Roman'});
      final figurCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Figür'});
      final cosplayKiyafetleriCategoryId = await txn.insert(
          TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Cosplay Kıyafetleri'});
      final gundelikKiyafetlerCategoryId = await txn.insert(
          TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Gündelik Kıyafetler'});
      final digerCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Diğer'});

      // Manga kategorisinin alt kategorilerini ekleyin
      final shounenMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Shounen Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Aksiyon',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Macera',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Komedi',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Drama',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Fantastik',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Spor',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bilim Kurgu',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Doğaüstü Güçler',
        COLUMN_CATEGORY_ID_FK: shounenMangaCategoryId
      });

      // Shoujo Manga kategorisinin alt kategorilerini ekleyin
      final shoujoMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Shoujo Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Romantik',
        COLUMN_CATEGORY_ID_FK: shoujoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Okul',
        COLUMN_CATEGORY_ID_FK: shoujoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Dram',
        COLUMN_CATEGORY_ID_FK: shoujoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Fantastik',
        COLUMN_CATEGORY_ID_FK: shoujoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kız Karakterler Odaklı',
        COLUMN_CATEGORY_ID_FK: shoujoMangaCategoryId
      });

      // Seinen Manga kategorisinin alt kategorilerini ekleyin
      final seinenMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Seinen Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Yetişkin',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Psikolojik',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Gizem',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bilim Kurgu',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Korku',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Doğaüstü Güçler',
        COLUMN_CATEGORY_ID_FK: seinenMangaCategoryId
      });

      // Josei Manga kategorisinin alt kategorilerini ekleyin
      final joseiMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Josei Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Romantik',
        COLUMN_CATEGORY_ID_FK: joseiMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Yetişkin',
        COLUMN_CATEGORY_ID_FK: joseiMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Dram',
        COLUMN_CATEGORY_ID_FK: joseiMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Keskin Yaşam',
        COLUMN_CATEGORY_ID_FK: joseiMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Psikolojik',
        COLUMN_CATEGORY_ID_FK: joseiMangaCategoryId
      });

      // Kodomo Manga kategorisinin alt kategorilerini ekleyin
      final kodomoMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Kodomo Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Çocuklar İçin',
        COLUMN_CATEGORY_ID_FK: kodomoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Eğitim',
        COLUMN_CATEGORY_ID_FK: kodomoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Komedi',
        COLUMN_CATEGORY_ID_FK: kodomoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Macera',
        COLUMN_CATEGORY_ID_FK: kodomoMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bilim Kurgu',
        COLUMN_CATEGORY_ID_FK: kodomoMangaCategoryId
      });

      // Harem Manga kategorisinin alt kategorilerini ekleyin
      final haremMangaCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Harem Manga'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Harem',
        COLUMN_CATEGORY_ID_FK: haremMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Romantik',
        COLUMN_CATEGORY_ID_FK: haremMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Komedi',
        COLUMN_CATEGORY_ID_FK: haremMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Okul',
        COLUMN_CATEGORY_ID_FK: haremMangaCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Drama',
        COLUMN_CATEGORY_ID_FK: haremMangaCategoryId
      });

      // Çizgi Roman kategorisinin alt kategorilerini ekleyin
      final cizgiRomanYayinEvleriCategoryId = await txn.insert(
          TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Çizgi Roman Yayınevleri'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Marvel',
        COLUMN_CATEGORY_ID_FK: cizgiRomanYayinEvleriCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'DC Comics',
        COLUMN_CATEGORY_ID_FK: cizgiRomanYayinEvleriCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Image Comics',
        COLUMN_CATEGORY_ID_FK: cizgiRomanYayinEvleriCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Dark Horse Comics',
        COLUMN_CATEGORY_ID_FK: cizgiRomanYayinEvleriCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Diğer yayınevleri',
        COLUMN_CATEGORY_ID_FK: cizgiRomanYayinEvleriCategoryId
      });

      // Figür kategorisinin alt kategorilerini ekleyin
      final animeFigurleriCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Anime Figürleri'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Popüler anime karakterleri',
        COLUMN_CATEGORY_ID_FK: animeFigurleriCategoryId
      });

      final cizgiRomanFigurleriCategoryId = await txn.insert(
          TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Çizgi Roman Figürleri'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Süper Kahraman figürleri',
        COLUMN_CATEGORY_ID_FK: cizgiRomanFigurleriCategoryId
      });

      // Cosplay Kıyafetleri kategorisinin alt kategorilerini ekleyin
      final animeKarakterleriCosplayKostumleriCategoryId = await txn.insert(
          TABLE_CATEGORIES,
          {COLUMN_CATEGORY_NAME: 'Anime Karakterleri Cosplay Kostümleri'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Popüler anime karakterleri için kostümler',
        COLUMN_CATEGORY_ID_FK: animeKarakterleriCosplayKostumleriCategoryId
      });

      final cizgiRomanKarakterleriCosplayKostumleriCategoryId = await txn
          .insert(TABLE_CATEGORIES, {
        COLUMN_CATEGORY_NAME: 'Çizgi Roman Karakterleri Cosplay Kostümleri'
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Süper Kahraman karakterleri için kostümler',
        COLUMN_CATEGORY_ID_FK: cizgiRomanKarakterleriCosplayKostumleriCategoryId
      });

      final orjinalCosplayTasarimlariCategoryId = await txn.insert(
          TABLE_CATEGORIES,
          {COLUMN_CATEGORY_NAME: 'Orjinal Cosplay Tasarımları'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME:
            'Kendi tasarımlarıyla cosplayerların ihtiyaç duyduğu kostümler',
        COLUMN_CATEGORY_ID_FK: orjinalCosplayTasarimlariCategoryId
      });

      // Erkek alt kategorileri
      final erkekCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Erkek'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Üst Giyim',
        COLUMN_CATEGORY_ID_FK: erkekCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Alt Giyim',
        COLUMN_CATEGORY_ID_FK: erkekCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Aksesuarlar',
        COLUMN_CATEGORY_ID_FK: erkekCategoryId
      });
      final erkekUstGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Üst Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'T-shirt\'ler',
        COLUMN_CATEGORY_ID_FK: erkekUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Ceketler',
        COLUMN_CATEGORY_ID_FK: erkekUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kazaklar',
        COLUMN_CATEGORY_ID_FK: erkekUstGiyimCategoryId
      });
      final erkekAltGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Alt Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Pantolonlar',
        COLUMN_CATEGORY_ID_FK: erkekAltGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şortlar',
        COLUMN_CATEGORY_ID_FK: erkekAltGiyimCategoryId
      });
      final erkekAksesuarlarCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Aksesuarlar'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kolye',
        COLUMN_CATEGORY_ID_FK: erkekAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bileklik',
        COLUMN_CATEGORY_ID_FK: erkekAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şapkalar',
        COLUMN_CATEGORY_ID_FK: erkekAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Gözlükler',
        COLUMN_CATEGORY_ID_FK: erkekAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Çantalar',
        COLUMN_CATEGORY_ID_FK: erkekAksesuarlarCategoryId
      });

      // kadin alt kategorileri
      final kadinCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'kadin'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Üst Giyim',
        COLUMN_CATEGORY_ID_FK: kadinCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Alt Giyim',
        COLUMN_CATEGORY_ID_FK: kadinCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Aksesuarlar',
        COLUMN_CATEGORY_ID_FK: kadinCategoryId
      });
      final kadinUstGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Üst Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'T-shirt\'ler',
        COLUMN_CATEGORY_ID_FK: kadinUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Ceketler',
        COLUMN_CATEGORY_ID_FK: kadinUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kazaklar',
        COLUMN_CATEGORY_ID_FK: kadinUstGiyimCategoryId
      });
      final kadinAltGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Alt Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Pantolonlar',
        COLUMN_CATEGORY_ID_FK: kadinAltGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Etekler',
        COLUMN_CATEGORY_ID_FK: kadinAltGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şortlar',
        COLUMN_CATEGORY_ID_FK: kadinAltGiyimCategoryId
      });
      final kadinAksesuarlarCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Aksesuarlar'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kolye',
        COLUMN_CATEGORY_ID_FK: kadinAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bileklik',
        COLUMN_CATEGORY_ID_FK: kadinAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şapkalar',
        COLUMN_CATEGORY_ID_FK: kadinAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Gözlükler',
        COLUMN_CATEGORY_ID_FK: kadinAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Çantalar',
        COLUMN_CATEGORY_ID_FK: kadinAksesuarlarCategoryId
      });

      // Unisex alt kategorileri
      final unisexCategoryId =
          await txn.insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Unisex'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Üst Giyim',
        COLUMN_CATEGORY_ID_FK: unisexCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Alt Giyim',
        COLUMN_CATEGORY_ID_FK: unisexCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Aksesuarlar',
        COLUMN_CATEGORY_ID_FK: unisexCategoryId
      });
      final unisexUstGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Üst Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'T-shirt\'ler',
        COLUMN_CATEGORY_ID_FK: unisexUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Ceketler',
        COLUMN_CATEGORY_ID_FK: unisexUstGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kazaklar',
        COLUMN_CATEGORY_ID_FK: unisexUstGiyimCategoryId
      });
      final unisexAltGiyimCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Alt Giyim'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Pantolonlar',
        COLUMN_CATEGORY_ID_FK: unisexAltGiyimCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şortlar',
        COLUMN_CATEGORY_ID_FK: unisexAltGiyimCategoryId
      });
      final unisexAksesuarlarCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Aksesuarlar'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kolye',
        COLUMN_CATEGORY_ID_FK: unisexAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Bileklik',
        COLUMN_CATEGORY_ID_FK: unisexAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Şapkalar',
        COLUMN_CATEGORY_ID_FK: unisexAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Gözlükler',
        COLUMN_CATEGORY_ID_FK: unisexAksesuarlarCategoryId
      });
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Çantalar',
        COLUMN_CATEGORY_ID_FK: unisexAksesuarlarCategoryId
      });

      // Diğer kategorisinin alt kategorilerini ekleyin
      final elSanatlariCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'El Sanatları'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Kendi el yapımı ürünler',
        COLUMN_CATEGORY_ID_FK: elSanatlariCategoryId
      });

      final koleksiyonlarCategoryId = await txn
          .insert(TABLE_CATEGORIES, {COLUMN_CATEGORY_NAME: 'Koleksiyonlar'});
      await txn.insert(TABLE_SUBCATEGORIES, {
        COLUMN_SUBCATEGORY_NAME: 'Para, pul, kart koleksiyonları',
        COLUMN_CATEGORY_ID_FK: koleksiyonlarCategoryId
      });
    });
  }
}
