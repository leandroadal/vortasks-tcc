import 'package:mobx/mobx.dart';
part 'page_store.g.dart';

class PageStore = PageStoreBase with _$PageStore;

abstract class PageStoreBase with Store {
  @observable
  // Para o bottom e rail navigator
  int selectedPage = 0;

  @action
  void setPage(int page) {
    selectedPage = page;
  }
}
