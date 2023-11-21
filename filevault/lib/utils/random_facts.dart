final fakta = [
  "Enkripsi telah ada sejak zaman kuno. Salah satu bentuk kriptografi tertua yang dikenal adalah metode Caesar, di mana setiap huruf dalam teks dienkripsi dengan menggesernya sejumlah langkah tertentu dalam abjad.",
  "Selama Perang Dunia II, Nazi Jerman menggunakan Enigma Machine, sebuah alat enkripsi mekanikal yang sangat canggih pada saat itu.",
  "Algoritma enkripsi RSA, yang dinamai sesuai dengan penemunya Ron Rivest, Adi Shamir, dan Leonard Adleman, adalah salah satu algoritma kunci publik paling terkenal. ",
  "Kriptografi kuantum adalah cabang kriptografi yang menggunakan prinsip-prinsip mekanika kuantum untuk mengamankan komunikasi.",
  "Advanced Encryption Standard (AES) adalah algoritma enkripsi simetris yang paling umum digunakan di seluruh dunia saat ini.",
  "Homomorphic encryption memungkinkan komputasi dilakukan pada data terenkripsi tanpa perlu mendekripsinya terlebih dahulu.",
  "Enkripsi end-to-end digunakan dalam aplikasi komunikasi seperti WhatsApp dan Signal, memastikan bahwa pesan hanya dapat dibaca oleh penerima yang dituju dan tidak dapat diakses oleh pihak ketiga atau penyedia layanan.",
  "Selain enkripsi, ada juga steganografi, yang melibatkan penyembunyian informasi di dalam media lain, seperti gambar atau audio, tanpa meningkatkan kecurigaan."
];

String getFakta(int data) {
  return fakta[data];
}

int getTotalFakta() {
  return fakta.length - 1;
}
