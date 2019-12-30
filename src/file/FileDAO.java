//package file;
//
//import util.DatabaseUtil;
//import java.io.IOException;
//import java.security.GeneralSecurityException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//public class FileDAO {
//
//
//
//    public int upload(String fileName, String fileRealName) {
//        String SQL = "INSERT INTO FILE VALUES(?, ?)";
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//        try{
//            conn = DatabaseUtil.getConnection();
//            pstmt = conn.prepareStatement(SQL);
//            pstmt.setString(1, fileName);
//            pstmt.setString(2, fileRealName);
//            return pstmt.executeUpdate();
//        }catch(SQLException e) {
//            System.err.println("fileUpload SQLException error");
//        } finally {
//            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
//            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
//        }
//        return -1; //데이터베이스 오류
//    }
//
//
//
//}
