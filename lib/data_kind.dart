enum DataKind {
  creature,
  plant,
  waterChange,
  feed,
  temperature,
  diary,
}

DataKind dataKind = DataKind.creature;
String collectionName = 'creature';
String unitName = '匹';

DataKind setDataKind(String kind) {
  switch (kind) {
    case '生き物' :
      dataKind = DataKind.creature;
      collectionName = 'creature';
      unitName = '匹';
      break;
    case '水草' :
      dataKind = DataKind.plant;
      collectionName = 'plant';
      unitName = '株';
      break;
    case '水交換' :
      dataKind = DataKind.waterChange;
      collectionName = 'waterChange';
      break;
    case '餌やり' :
      dataKind = DataKind.feed;
      collectionName = 'feed';
      break;
    case '水温' :
      dataKind = DataKind.temperature;
      collectionName = 'temperature';
      break;
    case '日記' :
      dataKind = DataKind.diary;
      collectionName = 'diary';
      break;
    default:
      break;
  }
  return dataKind;
}