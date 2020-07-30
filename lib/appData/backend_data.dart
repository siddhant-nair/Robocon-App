import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/appData/userdata_model.dart';
import 'package:firebase_prac/appData/list_model.dart';

class backEnd{

  final String uid;
  backEnd({this.uid});

  final CollectionReference mechanicalAgenda = Firestore.instance.collection('mechanical');
  final CollectionReference electronicsAgenda = Firestore.instance.collection('electronics');
  final CollectionReference programmingAgenda = Firestore.instance.collection('programming');

  final CollectionReference masjidList = Firestore.instance.collection('masjidList');

  //linking user data with uid
  Future updateMechUserData(String name, String field, String time, String agenda) async {
    if(time == null) { time = DateTime.now().toString(); }
    return await mechanicalAgenda.document('$time ${this.uid}').setData({
      'name': name,
      'field': field,
      'agenda': agenda,
      'time': "$time",
    });
  }
  Future updateElecUserData(String name, String field, String time, String agenda) async {
    if(time == null) { time = DateTime.now().toString(); }
      return await electronicsAgenda.document('$time ${this.uid}').setData({
        'name': name,
        'field': field,
        'agenda': agenda,
        'time': "$time",
      });
    }
  Future updateProgUserData(String name, String field, String time, String agenda) async {
      if(time == null) { time = DateTime.now().toString(); }
      return await programmingAgenda.document('$time ${this.uid}').setData({
        'name': name,
        'field': field,
        'agenda': agenda,
        'time': "$time",
      });
    }

  Future updateList(List items, String name, String time, int total) async {
    if(time == null) { time = DateTime.now().toString(); }
    return await masjidList.document('$time ${this.uid}').setData({
      'name': name,
      'list': items,
      'total': total,
      'time': "$time",
    });
  }

  //deleting a doc
  void deleteMechDoc(String time){
    mechanicalAgenda.document('$time ${this.uid}').delete();
  }
  void deleteElecDoc(String time){
      electronicsAgenda.document('$time ${this.uid}').delete();
    }
  void deleteProgDoc(String time){
      programmingAgenda.document('$time ${this.uid}').delete();
    }
  void deleteListDoc(String time){
      masjidList.document('$time ${this.uid}').delete();
    }


  List<AgendaObject> parseUserData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) =>
      AgendaObject(
        name: doc.data['name'],
        field: doc.data['field'],
        agenda: doc.data['agenda'],
        time: doc.data['time'],
      )
    ).toList();
  }

  List<MasjidObject> parseListData(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) =>
        MasjidObject(
        items: doc.data['list'],
        listName: doc.data['name'],
        total: doc.data['total'],
        time: doc.data['time'],
      )
    ).toList();
  }

  Stream<List<AgendaObject>> get backEndDataM {
    return mechanicalAgenda.snapshots()
              .map(parseUserData);
  }
  Stream<List<AgendaObject>> get backEndDataE {
      return electronicsAgenda.snapshots()
                .map(parseUserData);
    }
  Stream<List<AgendaObject>> get backEndDataP {
      return programmingAgenda.snapshots()
                .map(parseUserData);
    }

  Stream<List<MasjidObject>> get backEndList {
      return masjidList.snapshots()
        .map(parseListData);
  }
}