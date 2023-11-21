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

### 5. jelaskan cara implementasi checklist step by step

1. Membuat file inventory_form yang meminta input name, amount, description dan memiliki validator.
Contoh untuk input nama:

```dart
Padding(
  padding: const EdgeInsets.all(8),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Nama Item",
      labelText: "Nama Item",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    onChanged: (String? value){
      setState(() {
        _name = value!;
      });
    },
    validator: (String? value){
      if(value == null || value.isEmpty){
        return "Nama tidak boleh kosong!";
      }
      return null;
    }
  ),
),
```

2. Mengarah pengguna ke halaman form ketika tombol "tambah item" ditekan seperti ini:

```dart
if(item.name == "Tambah Item"){
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => const InventoryFormPage()));
}
```

3. Memunculkan data dalam sebuah pop-up ketika save ditekan:

```dart
showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text("Item berhasil disimpan"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Nama: $_name'),
            Text('Harga: $_price'),
            Text('Deskripsi: $_description'),
          ],
        )
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          }, 
        )
      ],
    );
  },
);
```
membuat drawer yang dapat mengarah ke halaman utama, daftar produk, dantambah item.
Contoh untuk yang halaman utama:

```dart
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text("Halaman utama"),
  onTap: () {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
        ));
  },
),
```

# Tugas 9

## pertanyaan

### 1. Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu?

Bisa, tapi lebih baik jika pakai model karena akan lebih terstruktur dan mempermudah pemeliharaan code.

## 2. Jelaskan fungsi dari CookieRequest  

Untuk autentikasi agar cookie dan session dapat dikelola dengan baik. Instance perlu dibagikan ke semua komponen agar semua komponen aplikasi menggunakan sesi yang sama untuk berkomunikasi dengan backend, juga agar lebih konsisten, aman , dan efisien sehingga memudahkan pengembangan dan pemeliharaan aplikasi.

## 3.  Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

- Mengirim permintaan http ke server dan menerika respons JSON

- mengubah respons JSON menjadi objek dart atau model data

- menampilkan informasi data pada UI flutter

## 4. Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django

- memasukkan data seperti username dan password pada form login pada flutter.

- mengirim data tersebut ke backend django ke endpointnya menerima request login. 

- Django menerima data login dan mengautentikasikan pengguna dan mengirimkan respons ke flutter 

- Flutter kemudian mengecek respon yang dikirimkan dari django

### 5. Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

1. Textfield: Input text

2. ElevatedButton: button dengan tampilan elevated yg dapat bereaksi ketika di tekan

3. Column : mengatur child secara vertical 

4. Sizedbox: dapat digunakan untuk memberikan jarak antar widget

5.  CircularProgressIndicator: Menampilkan indikator loading sirkuler, biasanya digunakan saat menunggu data dimuat.

6. ListView.builder: membuat daftar item scrollable yang dibangun secara dinamis. Digunakan untuk menampilkan daftar produk/item.

7. Provider : Paket manajemen state yang digunakan untuk mengelola data di berbagai bagian aplikasi.

### step by step

1. membuat halaman login

```dart
import 'package:inventory/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:inventory/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
    runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
const LoginApp({super.key});

@override
Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        theme: ThemeData(
            primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
    );
    }
}

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                            ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                            ),
                            obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                            onPressed: () async {
                                String username = _usernameController.text;
                                String password = _passwordController.text;

                                // Cek kredensial
                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                // gunakan URL http://10.0.2.2/
                                final response = await request.login("http://127.0.0.1:8000/auth/login/", {
                                'username': username,
                                'password': password,
                                });
                    
                                if (request.loggedIn) {
                                    String message = response['message'];
                                    String uname = response['username'];
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                            SnackBar(content: Text("$message Selamat datang, $uname.")));
                                    } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text('Login Gagal'),
                                            content:
                                                Text(response['message']),
                                            actions: [
                                                TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                ),
                                            ],
                                        ),
                                    );
                                }
                            },
                            child: const Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed:() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          }, 
                          child: Text("wanna register?"))
                    ],
                ),
            ),
        );
    }
}
```

2. membuat file khusus untuk class model nya.
item.dart:

```dart
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    String model;
    int pk;
    Fields fields;

    Item({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );


    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    DateTime dateAdded;
    int amount;
    String description;
    int user;

    Fields({
        required this.name,
        required this.dateAdded,
        required this.amount,
        required this.description,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        amount: json["amount"],
        description: json["description"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
        "user": user,
    };
}
```

3. membuat halaman yang berisi daftar semua item:
```dart
body: FutureBuilder(
  future: fetchProduct(),
  builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
      } else {
          if (!snapshot.hasData) {
          return const Column(
              children: [
              Text(
                  "Tidak ada data produk.",
                  style:
                      TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
              SizedBox(height: 8),
              ],
          );
      } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              // if(snapshot.data![index].fields.name == currentUser){

              // }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailPage(item: snapshot.data![index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.name}",
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.amount}"),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.description}"),
                    ],
                  ),
                ),
              );
            },
          );

        }
      }
  });
```

5. Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.

```dart
Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(16),
          child:Column(
            
            children: [
              Text('Name: ${item.fields.name}', style: TextStyle(fontSize: 20)),
              Text('Amount: ${item.fields.amount}', style: TextStyle(fontSize: 18)),
              Text('Description: ${item.fields.description}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to List'),
              ),
            ],
          )

        )
      ),
    );
  }
```
