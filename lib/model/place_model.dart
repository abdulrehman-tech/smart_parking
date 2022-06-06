class Place{
  final String imageUrl;
  final String mall;
  final String city;

  Place({required this.imageUrl, required this.mall, required this.city});

}

final places = [
  Place(
    imageUrl : 'assets/pvj.png',
    mall : 'Paris Van Java',
    city:'Jl. Sukajadi No.131-139, Cipedes, Kec. Sukajadi, Kota Bandung, Jawa Barat, 40162',
  ),
  Place(
    imageUrl : 'assets/fcl.png',
    mall : 'Festival City Link',
    city:'Jl. Peta No.241, Suka Asih, Kec. Bojongloa Kaler, Kota Bandung, Jawa Barat, 40232',
  ),
  Place(
    imageUrl : 'assets/paskal.png',
    mall : '23 Paskal',
    city:'Jl. Pasir Kaliki No.25-27, Kb. Jeruk, Kec. Andir, Kota Bandung, Jawa Barat, 40241',
  ),
  Place(
    imageUrl : 'assets/ip.jpg',
    mall : 'Istana Plaza',
    city:'Jl. Pasir Kaliki No.121-123, Pamoyanan, Kec. Cicendo, Kota Bandung, Jawa Barat, 40173',
  ),

];