\# AGENTS.md — catatan\_polnes



\## Perintah Verifikasi



Jalankan setelah setiap perubahan; jangan menyatakan pekerjaan

selesai sebelum ketiganya berhasil tanpa galat:



&#x20;   dart format .

&#x20;   flutter analyze

&#x20;   flutter test



\## Aturan Tambahan



1\. \*\*Jangan push langsung ke branch `main`.\*\* Semua perubahan kode

&#x20;  harus melalui branch baru dan pull request. Ini menjaga `main`

&#x20;  selalu dalam kondisi stabil dan teruji, serta memudahkan

&#x20;  penelusuran riwayat jika terjadi galat — kesalahan cukup

&#x20;  diperbaiki di branch/PR-nya tanpa mengganggu kode utama.



2\. \*\*Jangan pernah menyimpan kredensial (API key, password, dll)

&#x20;  langsung di dalam kode.\*\* Karena repositori ini bersifat publik,

&#x20;  data sensitif yang ter-commit berisiko ditemukan dan disalahgunakan

&#x20;  orang lain. Gunakan `.gitignore` agar berkas semacam itu tidak

&#x20;  pernah ikut terlacak oleh Git.



3\. \*\*Gunakan `const` pada widget yang bersifat statis (tidak berubah).\*\*

&#x20;  Widget `const` tidak perlu dibangun ulang setiap kali `build()`

&#x20;  dipanggil, sehingga menghemat sumber daya dan menjaga performa

&#x20;  aplikasi tetap ringan.

