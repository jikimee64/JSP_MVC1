package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil { //DB와 연동되는 부분을 정의

	public static Connection getConnection() { //접속한 상태를 반환
		try {
			String dbURL = "jdbc:mysql://localhost:3306/dontcallme?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword ="1q2w3e4r1!";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //오류가 발생한경우 null 반환
	}

}
