import 'package:flutter_coinid/models/node/node_model.dart';
import 'package:flutter_coinid/utils/sharedPrefer.dart';

import '../../public.dart';

class SystemSetPage extends StatefulWidget {
  SystemSetPage({Key key}) : super(key: key);

  @override
  _SystemSetPageState createState() => _SystemSetPageState();
}

class _SystemSetPageState extends State<SystemSetPage> {
  int amount = 0;
  int language = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetType();
    _configNodeList();
  }

  Future<void> _configNodeList() async {
    List<NodeModel> nodes = await NodeModel.queryNodeByIsChoose(true);
    if (nodes == null || nodes.length == 0) {
      nodes = [];
      NodeModel node = NodeModel(
          "https://btc-api.coinid.pro",
          MCoinType.MCoinType_BTC.index,
          true,
          true,
          MNodeNetType.MNodeNetType_Main.index);
      nodes.add(node);
      // node = NodeModel(
      //     "https://mainnet-eos.coinid.pro",
      //     MCoinType.MCoinType_EOS.index,
      //     true,
      //     true,
      //     MNodeNetType.MNodeNetType_Main.index);
      // nodes.add(node);
      node = NodeModel(
          "https://mainnet-eth.coinid.pro",
          MCoinType.MCoinType_ETH.index,
          true,
          true,
          MNodeNetType.MNodeNetType_Main.index);
      nodes.add(node);
      // node = NodeModel(
      //     "https://mainnet-gvns.coinid.pro",
      //     MCoinType.MCoinType_VNS.index,
      //     true,
      //     true,
      //     MNodeNetType.MNodeNetType_Main.index);
      // nodes.add(node);
      // node = NodeModel(
      //     "https://mainnet-bytom.coinid.pro",
      //     MCoinType.MCoinType_BTM.index,
      //     true,
      //     true,
      //     MNodeNetType.MNodeNetType_Main.index);
      // nodes.add(node);
      // node = NodeModel(
      //     "https://ltc-explorer.coinid.pro",
      //     MCoinType.MCoinType_LTC.index,
      //     true,
      //     true,
      //     MNodeNetType.MNodeNetType_Main.index);
      // nodes.add(node);
      // node = NodeModel(
      //     "https://btc-api.coinid.pro",
      //     MCoinType.MCoinType_USDT.index,
      //     true,
      //     true,
      //     MNodeNetType.MNodeNetType_Main.index);
      // nodes.add(node);
      NodeModel.insertNodeDatas(nodes);
    }
  }

  void getSetType() async {
    int newamount = await getAmountValue();
    int newlanguage = await getLanguageValue();

    setState(() {
      amount = newamount;
      language = newlanguage;
    });
  }

  Future<void> _cellTap(int index) async {
    if (index == 0 || index == 1) {
      Routers.push(context, Routers.modifiySetPage, params: {"settype": index})
          .then((value) => {
                getSetType(),
              });
    } else {
      Routers.push(context, Routers.nodeListPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
        title: CustomPageView.getDefaultTitle(
            titleStr: "system_settings".local(context: context)),
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => {
                _cellTap(0),
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  bottom: OffsetWidget.setSc(27),
                ),
                margin: EdgeInsets.only(
                    left: OffsetWidget.setSc(19),
                    right: OffsetWidget.setSc(19),
                    top: OffsetWidget.setSc(40)),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFEAEFF2), width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      LoadAssetsImage(
                        Constant.ASSETS_IMG + "icon/icon_currency.png",
                      ),
                      OffsetWidget.hGap(12),
                      Text(
                        "system_currency".local(context: context),
                        style: TextStyle(
                            color: Color(0xFF161D2D),
                            fontSize: OffsetWidget.setSp(15),
                            fontWeight: FontWightHelper.medium),
                      ),
                    ]),
                    Row(
                      children: <Widget>[
                        Text(
                          amount == 0 ? "CNY" : "USD",
                          style: TextStyle(
                              color: Color(0xFFACBBCF),
                              fontSize: OffsetWidget.setSp(15),
                              fontWeight: FontWightHelper.regular),
                        ),
                        OffsetWidget.hGap(8),
                        LoadAssetsImage(
                          Constant.ASSETS_IMG + "icon/arrow_black_right.png",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => {
                _cellTap(1),
              },
              child: Container(
                alignment: Alignment.center,
                height: OffsetWidget.setSc(80),
                margin: EdgeInsets.only(
                  left: OffsetWidget.setSc(19),
                  right: OffsetWidget.setSc(19),
                ),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFEAEFF2), width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      LoadAssetsImage(
                        Constant.ASSETS_IMG + "icon/icon_language.png",
                      ),
                      OffsetWidget.hGap(12),
                      Text(
                        "language".local(context: context),
                        style: TextStyle(
                            color: Color(0xFF161D2D),
                            fontSize: OffsetWidget.setSp(15),
                            fontWeight: FontWightHelper.medium),
                      ),
                    ]),
                    Row(
                      children: <Widget>[
                        Text(
                          language == 0
                              ? "system_zh_hans".local(context: context)
                              : "system_en".local(context: context),
                          style: TextStyle(
                              color: Color(0xFFACBBCF),
                              fontSize: OffsetWidget.setSp(15),
                              fontWeight: FontWightHelper.regular),
                        ),
                        OffsetWidget.hGap(8),
                        LoadAssetsImage(
                          Constant.ASSETS_IMG + "icon/arrow_black_right.png",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => {
                _cellTap(2),
              },
              child: Container(
                alignment: Alignment.center,
                height: OffsetWidget.setSc(80),
                margin: EdgeInsets.only(
                  left: OffsetWidget.setSc(19),
                  right: OffsetWidget.setSc(19),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      LoadAssetsImage(
                        Constant.ASSETS_IMG + "icon/icon_nodes.png",
                      ),
                      OffsetWidget.hGap(12),
                      Text(
                        "nodelist_title".local(context: context),
                        style: TextStyle(
                            color: Color(0xFF161D2D),
                            fontSize: OffsetWidget.setSp(15),
                            fontWeight: FontWightHelper.medium),
                      ),
                    ]),
                    LoadAssetsImage(
                      Constant.ASSETS_IMG + "icon/arrow_black_right.png",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
