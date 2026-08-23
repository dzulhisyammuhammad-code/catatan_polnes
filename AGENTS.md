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

