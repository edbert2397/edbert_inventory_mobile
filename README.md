# Tugas 7

## Pertanyaan

### 1. Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
Dalam pengembangan aplikasi Flutter, perbedaan utama antara stateless dan stateful widget terletak pada bagaimana mereka mengelola data dan bagaimana mereka dirender ulang di layar.

*Stateless Widget:
    Stateless widget tidak dapat mengubah tampilannya setelah dibuat. Ini berarti propertinya final dan tidak bisa berubah. Cocok untuk bagian antarmuka pengguna yang sederhana dan tetap, seperti icon, text, dan tombol yang tidak berubah berdasarkan interaksi pengguna.

*Stateful Widget:
    Stateful widget bisa mengubah tampilannya. Mereka memiliki state yang bisa diperbarui, memungkinkan mereka untuk bereaksi terhadap perubahan. Contoh Penggunaan: Cocok untuk bagian antarmuka pengguna yang dinamis seperti formulir, pembaruan item, atau halaman yang menampilkan data yang sering berubah.

### 2. Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

Berikut adalah daftar widget tersebut beserta fungsinya:

MaterialApp: Widget utama yang digunakan untuk menginisialisasi aplikasi. Biasanya merupakan parent utama dari widget kita. Biasanya digunakan untuk mengatur tema dan color palette dari aplikasi kita.

InkWell: Digunakan untuk memberikan efek sentuhan. Ini memungkinkan untuk menangani interaksi pengguna. Biasanya diterapkan pada button.

SnackBar: Widget pesan sementara yang muncul di bagian bawah layar, biasanya digunakan untuk memberikan feedback kepada pengguna tentang suatu aksi.

Column: Merupakan widget layout yang mengatur childnya secara vertikal.

Icon: Widget ini menampilkan ikon dari set data ikon, seperti Icons yang tersedia di Flutter.

Padding: Widget ini memberikan padding, yang merupakan ruang kosong di sekitar child widget.

Text: Menampilkan string teks dengan style yang diberikan.

Center: Digunakan untuk mengatur childnya pada posisi ke tengah secara horizontal dan vertikal

Scaffold: Memberikan struktur dasar layout visual untuk aplikasi Flutter, termasuk AppBar, Drawer, dan BottomNavigationBar, serta menyediakan API untuk menampilkan drawer, snack bar, dan bottom sheet.

AppBar: Biasanya ditampilkan di bagian atas Scaffold, berisi judul dan mungkin beberapa tindakan tambahan.

SingleChildScrollView: Widget ini memberikan kemampuan scroll pada anak-anaknya, yang berguna ketika konten bisa lebih besar dari viewport.

Padding: Digunakan untuk memberikan padding di sekitar kolom utama dalam Scaffold.

GridView.count: Digunakan untuk membuat grid layout dengan jumlah kolom yang diberikan.

Semua widget ini digunakan untuk membangun tampilan utama aplikasi Kita dan menampilkan daftar item dalam grid dengan respons saat diklik.

### 3. Step by step implementasi

#### 1. Membuat proyek Flutter baru.

Membuat proyek baru pada flutter:
```sh
flutter create inventory
```

#### 2. Memisahkan main.dart menjadi menu.dart

Kita buat `main.dart` mereturn widget yang ada pada `menu.dart`.  

Pada `main.dart`. Dimana `MyHomePage()` adalah class widget pada `menu.dart`.
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```

#### 3. Menyusun Widget pada `menu.dart`

Pada `menu.dart`, implementasikan appbar terlebih dahulu.
```dart
class MyHomePage extends StatelessWidget {
	MyHomePage({Key? key}) : super(key: key);

	final List<ShopItem> items = [
		ShopItem("Lihat Item", Icons.checklist),
		ShopItem("Tambah Item", Icons.add_shopping_cart),
		ShopItem("Logout", Icons.logout),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
                title: const Text(
                'Inventory',
                ),
                backgroundColor: Colors.indigo,
            ),
			body: ...
		)
	}
```

Appbar ini akan terdapat text "Inventory" dengan background indigo.

Selanjutnya, pada halaman myHomePage kita akan membuat halaman ini dapat discroll. Kelanjutan `body` pada widget `Scaffold` dibungkus dengan `SingleChildScrollView`. Di dalamnya terdapat grid layout yang akan berisi 3 menu utama(ShopItem). Grid layout dapat diimplementasikan dengan menggunakan `GridView`.

```dart
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist,Colors.blue),
    ShopItem("Tambah Item", Icons.add_shopping_cart,Colors.indigo),
    ShopItem("Logout",Icons.logout,Colors.red),
  ];
...
body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top:10,bottom:10),
                child:  Text(
                  'Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item){
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ) ,
```

Child pada GridView  akan berupa widget, yaitu `ShopCard`. Yang akan diimplementasikan sebagai berikut. 

```dart
class ShopItem{
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name,this.icon,this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        onTap: (){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
```

`ShopCard` seperti sebuah button yang teredapat 3 pilihan menu kita, yaitu "Lihat Item", "Tambah Item", dan "Logout". `onTap` adalah fungsi yang akan dijalankan ketika button tersebut ditekan, yaitu membuat sebuah notifikasi "Kamu telah menekan tombol X" dimana X adalah button yang ditekan.

Saya juga menambahkan color pada ShopItem agar setiap ShopItem dapat menyimpan color nya masing-masing.

# Tugas 8

## Pertanyaan 

### 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement()

Navigator.push():
Fungsinya adalah untuk menambahkan rute baru ke tumpukan navigator.
Saat menggunakan Navigator.push(), halaman baru ditumpuk di atas halaman sebelumnya.
Halaman sebelumnya tetap ada di bawah halaman baru, dan pengguna dapat kembali ke halaman sebelumnya dengan tombol back atau gestur navigasi.
contoh penerapan : aplikasi dengan dua halaman: Halaman Utama dan Halaman Detail. Ketika pengguna mengeklik item di Halaman Utama, kita ingin membawanya ke Halaman Detail tanpa menghilangkan Halaman Utama dari tumpukan navigasi.

Navigator.pushReplacement():

Fungsinya adalah menggantikan rute saat ini dengan rute baru di tumpukan navigator.
Saat menggunakan Navigator.pushReplacement(), halaman saat ini dihapus dari tumpukan dan digantikan dengan halaman baru.
Pengguna tidak dapat kembali ke halaman sebelumnya karena sudah digantikan.
contoh penerapan: Dalam kasus alur login, setelah pengguna berhasil masuk, kita ingin membawanya ke Halaman Utama dan menghapus Halaman Login dari tumpukan navigasi.

### 2. Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya 

1.Container:
Container adalah kotak dekoratif yang dapat dikonfigurasi untuk menentukan dimensi, padding, margin, dan latar belakang.
Penggunaan: Cocok untuk membuat widget dengan dekorasi khusus, seperti warna latar belakang, border, atau shadow.

2.Column dan Row:
Column mengatur childnya secara vertikal, sedangkan Row mengaturnya secara horizontal.
Penggunaan: Ideal untuk membuat layout linier, seperti list item.

3.GridView:
GridView menyusun widget dalam grid dua dimensi.
Penggunaan: Baik untuk menampilkan data dalam format grid.

4.ListView:
ListView menyusun widget secara linier pada sumbu vertikal atau horizontal.
Penggunaan: Cocok untuk daftar yang dapat scroll.

5.Padding:
Padding menambahkan ruang kosong di sekitar widget lain.
Penggunaan: Digunakan untuk memberikan ruang tambahan di dalam atau di sekitar widget.

6.Align dan Center:
Align mengontrol posisi anak di dalam dirinya, sedangkan Center adalah versi khusus dari Align yang menempatkan anaknya di tengah.
Penggunaan: Berguna untuk mengontrol posisi spesifik widget dalam kontainer yang lebih besar.

7.Table:
Table menampilkan widget dalam format tabel dengan baris dan kolom.
Penggunaan: Berguna untuk data yang terstruktur seperti tabel.

### 3. Elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan 
TextFormField, Elemen ini digunakan untuk mengumpulkan input nama item,harga, dan deskripsi dari user. TextFormField juga memungkinkan validasi input (misalnya, memastikan bahwa nama tidak kosong) dan penyesuaian input teks (seperti hint dan label) sehingga sangat cocok untuk input teks sederhana.

### 4. penerapan clean architecture pada aplikasi Flutter
Penerapan Clean Architecture pada aplikasi Flutter melibatkan pemisahan kode menjadi bagian yang berbeda dengan tanggung jawab yang terpisah. Arsitektur ini bertujuan untuk menghasilkan kode yang mudah dipelihara.
