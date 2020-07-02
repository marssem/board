package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
private static final String URL = "jdbc:mariadb://localhost:3306/java";
private static final String USER = "root";
private static final String PWD = "1234";
private static Connection conn;
private static void init() {
	try {
		Class.forName("org.mariadb.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
}
public static Connection getConnection() {
	if(conn==null) {
		try {init();
			conn = DriverManager.getConnection(URL,USER,PWD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}
	return conn;
}
	public static void close(){
		if(conn!=null) {
			try {
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

public static void main(String[] args) {
	getConnection();
}
}