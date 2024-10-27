import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String userName = dotenv.env['dbUserName'] ?? '';
final String password = dotenv.env['dbPass'] ?? '';

final pool = MySQLConnectionPool(
  host: '127.0.0.1',
  port: 3306,
  userName: userName,
  password: password,
  maxConnections: 10,
  databaseName: 'hospital_map', // optional,
);
