import 'package:entregas_app/UI/Pages/Entregas/entregas_controller.dart';
import 'package:entregas_app/models/order.dart';
import 'package:entregas_app/utils/my_colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ListadoPage extends StatefulWidget {
  const ListadoPage({super.key});

  @override
  State<ListadoPage> createState() => _ListadoPageState();
}

class _ListadoPageState extends State<ListadoPage> {
  EntregasListController _con = new EntregasListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.status!.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.status.length, (index) {
                return Tab(
                  child: Text(_con.status[index] ?? ''),
                );
              }),
            ),
          ),
        ),
        // drawer: _drawer(),
        body: TabBarView(
          children: _con.status.map((String status) {
            return FutureBuilder(
                future: _con.getOrders(status),
                builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardOrder(snapshot.data![index], status);
                          });
                    } else {
                      return Text('No hay ordenes');
                    }
                  } else {
                    return Text('No hay ordenes');
                    // return NoDataWidget(text: 'No hay ordenes');
                  }
                });
          }).toList(),
        ),
      ),
    );
  }

  Widget _cardOrder(Order order, String status) {
    return GestureDetector(
      onTap: () {
        // _con.openBottomSheet(order);
      },
      child: Container(
        height: 155,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          color: Colors.purple,
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        order.nombre,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        order.direccion,
                        style: const TextStyle(fontSize: 11, color: Colors.white),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        order.toping,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          child: (status == 'TERMINADO') ? Text('Ir a entregar pedido') : Text('Terminar pedido'),
                          onPressed:()=>{
                            
                            _con.putPedido(status, order.idLineaPedido)
                            
                          } 
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
