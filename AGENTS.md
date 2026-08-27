# AGENTS.md — catatan_polnes


## Perintah Verifikasi


Jalankan setelah setiap perubahan; jangan menyatakan pekerjaan
selesai sebelum ketiganya berhasil tanpa galat:


   dart format .
   flutter analyze  
   flutter test



## Aturan Tambahan


1. **Jangan push langsung ke branch `main`.** Semua perubahan kode
  harus melalui branch baru dan pull request. Ini menjaga `main`
  selalu dalam kondisi stabil dan teruji, serta memudahkan
  penelusuran riwayat jika terjadi galat — kesalahan cukup
  diperbaiki di branch/PR-nya tanpa mengganggu kode utama.

2. **Jangan pernah menyimpan kredensial (API key, password, dll)
  langsung di dalam kode.** Karena repositori ini bersifat publik,
  data sensitif yang ter-commit berisiko ditemukan dan disalahgunakan
  orang lain. Gunakan `.gitignore` agar berkas semacam itu tidak
  pernah ikut terlacak oleh Git.

3. **Gunakan `const` pada widget yang bersifat statis (tidak berubah).**
  Widget `const` tidak perlu dibangun ulang setiap kali `build()`
  dipanggil, sehingga menghemat sumber daya dan menjaga performa
  aplikasi tetap ringan.

4. **Berkas di dalam folder lib/domain dilarang mengimpor package:flutter.**
   Lapisan domain adalah inti logika murni aplikasi; mengimpor Flutter akan
   mencemarinya dengan urusan tampilan, sehingga pengujian tidak bisa
   dilakukan cepat tanpa emulator.

5. **Setiap TextEditingController (atau controller lain) wajib dihancurkan
   di method dispose().** Tanpa itu, controller menjadi "hantu" yang terus
   memakan memori RAM meski layarnya sudah ditutup, berisiko membuat
   aplikasi berat dan crash.

6. **Di dalam Notifier (Riverpod), memanggil repository saja tidak cukup;
   wajib memanggil ulang state = ... setelahnya.** Ini berfungsi sebagai
   "bel alarm" bagi Riverpod untuk memberi tahu tampilan bahwa data
   berubah, sehingga layar bisa merender ulang secara otomatis.