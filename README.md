# Orangtua Delivery (Flutter)

Versi pengembangan dari proyek awal Orangtua Delivery.

## Fitur yang ditambahkan
- Kategori dan pencarian restoran/menu.
- Menu dapat dimasukkan ke keranjang, jumlah item dapat ditambah/dikurangi, dan item dapat dihapus.
- Subtotal, ongkir, dan total checkout dihitung dari keranjang.
- Pesanan tersimpan secara lokal dan statusnya dapat diperbarui dari mode pemilik.
- Profil dapat diedit dan disimpan.
- Mode pembeli/pemilik restoran.
- Pemilik dapat menambah dan mengedit menu.
- AI Food Assistant memberikan rekomendasi berbasis menu dan membantu memeriksa status pesanan.
- Profil, keranjang, pesanan, pilihan peran, dan perubahan menu disimpan di perangkat menggunakan `shared_preferences`.

## Menjalankan proyek
1. Ekstrak folder proyek.
2. Buka folder `frontendorangtua` di VS Code.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run` atau `flutter run -d chrome`.

## Catatan batasan
Ini masih prototipe tugas: login belum memakai autentikasi sungguhan, mode pemilik belum memakai akun/otorisasi backend, pembayaran QRIS/COD hanya simulasi, dan AI masih berupa rekomendasi lokal berbasis aturan (belum memanggil model AI eksternal). Data disimpan di perangkat yang menjalankan aplikasi; sinkronisasi antarpengguna/perangkat membutuhkan backend.
