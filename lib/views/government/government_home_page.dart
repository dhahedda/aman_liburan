import 'package:aman_liburan/blocs/government/home_statistic/home_statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GovernmentHomePage extends StatelessWidget {
  GovernmentHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeStatisticBloc>(
      create: (ctx) => HomeStatisticBloc(),
      child: GovernmentHomeScreen(),
    );
  }
}

class GovernmentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea( 
        child: LayoutBuilder( 
          builder: (BuildContext context, BoxConstraints viewportConstraints) { 
            return SingleChildScrollView( 
              padding: EdgeInsets.all(16), 
              child: ConstrainedBox( 
                constraints: BoxConstraints( 
                  minHeight: viewportConstraints.maxHeight, 
                ), 
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [ 
                        Column( 
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: <Widget>[ 
                            Text( 
                              'Selamat Datang', 
                              style: TextStyle( 
                                color: Color(0xff828282), 
                              ) 
                            ), 
                            Text( 
                              'Admin Dinpar', 
                              style: Theme.of(context).textTheme.headline5.copyWith( 
                                color: Color(0xff333333), 
                              ) 
                            ) 
                          ], 
                        ), 
                        CircleAvatar( 
                          child: ClipOval( 
                              child: Icon(Icons.person, size: 25)), 
                          radius: 25, 
                        ), 
                      ], 
                    ), 
                    SizedBox(height: 20), 
                    Text( 
                      'Statistik Wisata di Majalengka', 
                      style: Theme.of(context).textTheme.headline6 
                    ), 
                    Text( 
                      'Update Terakhir: Rabu, 19 Agustus 2020 15.30', 
                      style: Theme.of(context).textTheme.bodyText2.copyWith( 
                        color: Color(0xff828282), 
                      ) 
                    ), 
                    SizedBox(height: 20), 
                    Container( 
                      padding: EdgeInsets.all(20), 
                      width: double.infinity, 
                      decoration: BoxDecoration( 
                        color: Color(0xff66C6BA), 
                        borderRadius: BorderRadius.circular(10.0), 
                      ), 
                      child: Column( 
                        children: [ 
                          Text( 
                            'OBJEK WISATA TERDAFTAR' 
                          ), 
                          SizedBox(height: 20), 
                          Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceAround, 
                            children: [ 
                              Column( 
                                children: [ 
                                  Text( 
                                    'Jumlah Objek Wisata', 
                                  ), 
                                  SizedBox(height: 10), 
                                  Text( 
                                    '123', 
                                    style: Theme.of(context).textTheme.headline4.copyWith( 
                                      color: Colors.white, 
                                    ), 
                                  ), 
                                  SizedBox(height: 10), 
                                  Row( 
                                    children: [ 
                                      Icon(Icons.arrow_upward), 
                                      Text('50') 
                                    ], 
                                  ) 
                                ], 
                              ), 
                              Column( 
                                children: [ 
                                  Text( 
                                    'Jumlah Objek Wisata', 
                                  ), 
                                  SizedBox(height: 10), 
                                  Text( 
                                    '3.345', 
                                    style: Theme.of(context).textTheme.headline4.copyWith( 
                                      color: Colors.white, 
                                    ), 
                                  ), 
                                  SizedBox(height: 10), 
                                  Row( 
                                    children: [ 
                                      Icon(Icons.arrow_upward), 
                                      Text('345') 
                                    ], 
                                  ) 
                                ], 
                              ), 
                            ], 
                          ) 
                        ], 
                      ) 
                    ), 
                    SizedBox(height: 20), 
                    Card( 
                      child: Container( 
                        width: double.infinity, 
                        padding: EdgeInsets.all(15), 
                        child: Column( 
                          children: [ 
                            Column( 
                              children: [ 
                                Text( 
                                  'ZONASI OBJEK WISATA', 
                                ), 
                                SizedBox(height: 15), 
                                Text( 
                                  '100', 
                                  style: Theme.of(context).textTheme.headline4.copyWith( 
                                    color: Color(0xffEB5757), 
                                  ), 
                                ), 
                                SizedBox(height: 10), 
                                Text( 
                                  'Objek Wisata Zona Merah', 
                                ), 
                                SizedBox(height: 20), 
                                Row( 
                                  mainAxisAlignment: MainAxisAlignment.spaceAround, 
                                  children: [ 
                                    Column( 
                                      children: [ 
                                        Text( 
                                          '10', 
                                          style: Theme.of(context).textTheme.headline4.copyWith( 
                                            color: Color(0xffF2C94C), 
                                          ), 
                                        ), 
                                        SizedBox(height: 10), 
                                        Text( 
                                          'Zona Kuning', 
                                        ), 
                                      ], 
                                    ), 
                                    SizedBox(width: 15), 
                                    Column( 
                                      children: [ 
                                        Text( 
                                          '13', 
                                          style: Theme.of(context).textTheme.headline4.copyWith( 
                                            color: Color(0xff219653), 
                                          ), 
                                        ), 
                                        SizedBox(height: 10), 
                                        Text( 
                                          'Zona Hijau', 
                                        ), 
                                      ], 
                                    ) 
                                  ], 
                                ) 
                              ], 
                            ), 
                          ], 
                        ), 
                      ), 
                    ) 
                  ], 
                ) 
              ) 
            ); 
          } 
        ) 
      ) 
    ); 
  }
}