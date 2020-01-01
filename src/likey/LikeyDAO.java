package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DatabaseUtil;

public class LikeyDAO {

    public int like(String userID, String evaluationID, String userIP) {
        String SQL = "INSERT INTO LIKEY VALUES(?, ?, ?)"; //?는 사용자가 직접 입력한 값
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL); //데이터를 실제로 넣어줄 수 있는 역할
            pstmt.setString(1, userID);
            pstmt.setString(2, evaluationID);
            pstmt.setString(3, userIP);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            System.err.println("like SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {e.printStackTrace();}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            if(rs != null) try {rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return -1; //추천 중복 오류
    }

}
