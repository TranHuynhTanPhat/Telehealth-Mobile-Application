import 'dart:convert';

class DrugResponse {
  String? id;
  List<String>? images;
  String? tenThuoc;
  String? dotPheDuyet;
  String? soQuyetDinh;
  String? pheDuyet;
  String? soDangKy;
  String? hoatChat;
  String? phanLoai;
  String? nongDo;
  String? taDuoc;
  String? baoChe;
  String? dongGoi;
  String? tieuChuan;
  String? tuoiTho;
  String? congTySx;
  String? congTySxCode;
  String? nuocSx;
  String? diaChiSx;
  String? congTyDk;
  String? nuocDk;
  String? diaChiDk;
  String? nhomThuoc;
  String? note;
  int? quantity;
  DrugResponse({
    this.id,
    this.images,
    this.tenThuoc,
    this.dotPheDuyet,
    this.soQuyetDinh,
    this.pheDuyet,
    this.soDangKy,
    this.hoatChat,
    this.phanLoai,
    this.nongDo,
    this.taDuoc,
    this.baoChe,
    this.dongGoi,
    this.tieuChuan,
    this.tuoiTho,
    this.congTySx,
    this.congTySxCode,
    this.nuocSx,
    this.diaChiSx,
    this.congTyDk,
    this.nuocDk,
    this.diaChiDk,
    this.nhomThuoc,
    this.note,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (images != null) {
      result.addAll({'images': images});
    }
    if (tenThuoc != null) {
      result.addAll({'tenThuoc': tenThuoc});
    }
    if (dotPheDuyet != null) {
      result.addAll({'dotPheDuyet': dotPheDuyet});
    }
    if (soQuyetDinh != null) {
      result.addAll({'soQuyetDinh': soQuyetDinh});
    }
    if (pheDuyet != null) {
      result.addAll({'pheDuyet': pheDuyet});
    }
    if (soDangKy != null) {
      result.addAll({'soDangKy': soDangKy});
    }
    if (hoatChat != null) {
      result.addAll({'hoatChat': hoatChat});
    }
    if (phanLoai != null) {
      result.addAll({'phanLoai': phanLoai});
    }
    if (nongDo != null) {
      result.addAll({'nongDo': nongDo});
    }
    if (taDuoc != null) {
      result.addAll({'taDuoc': taDuoc});
    }
    if (baoChe != null) {
      result.addAll({'baoChe': baoChe});
    }
    if (dongGoi != null) {
      result.addAll({'dongGoi': dongGoi});
    }
    if (tieuChuan != null) {
      result.addAll({'tieuChuan': tieuChuan});
    }
    if (tuoiTho != null) {
      result.addAll({'tuoiTho': tuoiTho});
    }
    if (congTySx != null) {
      result.addAll({'congTySx': congTySx});
    }
    if (congTySxCode != null) {
      result.addAll({'congTySxCode': congTySxCode});
    }
    if (nuocSx != null) {
      result.addAll({'nuocSx': nuocSx});
    }
    if (diaChiSx != null) {
      result.addAll({'diaChiSx': diaChiSx});
    }
    if (congTyDk != null) {
      result.addAll({'congTyDk': congTyDk});
    }
    if (nuocDk != null) {
      result.addAll({'nuocDk': nuocDk});
    }
    if (diaChiDk != null) {
      result.addAll({'diaChiDk': diaChiDk});
    }
    if (nhomThuoc != null) {
      result.addAll({'nhomThuoc': nhomThuoc});
    }
    if (note != null) {
      result.addAll({'note': note});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }

    return result;
  }

  factory DrugResponse.fromMap(Map<String, dynamic> map) {
    return DrugResponse(
      id: map['id'],
      images: map['images'] != null
          ? List<String>.from(
              map['images']?.map(
                (x) => x.toString(),
              ),
            )
          : [],
      tenThuoc: map['tenThuoc'],
      dotPheDuyet: map['dotPheDuyet'],
      soQuyetDinh: map['soQuyetDinh'],
      pheDuyet: map['pheDuyet'],
      soDangKy: map['soDangKy'],
      hoatChat: map['hoatChat'],
      phanLoai: map['phanLoai'],
      nongDo: map['nongDo'],
      taDuoc: map['taDuoc'],
      baoChe: map['baoChe'],
      dongGoi: map['dongGoi'],
      tieuChuan: map['tieuChuan'],
      tuoiTho: map['tuoiTho'],
      congTySx: map['congTySx'],
      congTySxCode: map['congTySxCode'],
      nuocSx: map['nuocSx'],
      diaChiSx: map['diaChiSx'],
      congTyDk: map['congTyDk'],
      nuocDk: map['nuocDk'],
      diaChiDk: map['diaChiDk'],
      nhomThuoc: map['nhomThuoc'],
      note: map['note'],
      quantity: map['quantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DrugResponse.fromJson(String source) =>
      DrugResponse.fromMap(json.decode(source));
}
