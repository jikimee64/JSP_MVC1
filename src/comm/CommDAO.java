package comm;

import bbs.Bbs;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommDAO {

    public String getDate() {
        String SQL = "SELECT NOW()";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1);
            }
        } catch(SQLException e) {
            System.err.println("getDate SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(rs != null) try {rs.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return "";
    }

    public int getNext() {
        String SQL = "SELECT commID FROM COMM ORDER BY commID DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1)+1;
            }
            return 1;
        } catch(SQLException e) {
            System.err.println("getNext SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(rs != null) try {rs.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }


    public int write(String userID, String commContent, int bbsID) {
        String SQL = "INSERT INTO COMM VALUES(?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, userID);
            pstmt.setString(3, getDate());
            pstmt.setString(4, commContent);
            pstmt.setInt(5, bbsID);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("write SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }


    public ArrayList<Comm> getList(int bbsID) {
        String SQL = "SELECT * FROM COMM WHERE bbsID = '" + bbsID + "' ORDER BY commID";
        ArrayList<Comm> list = new ArrayList<Comm>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Comm comm = new Comm();
                comm.setCommID(rs.getInt(1));
                comm.setUserID(rs.getString(2));
                comm.setCommDate(rs.getString(3));
                comm.setCommContent(rs.getString(4));
                comm.setBbsID(rs.getInt(5));
                list.add(comm);
            }
        } catch(SQLException e) {
            System.err.println("getList SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return list;
    }


    public int delete(int commID, int bbsID) {
        String SQL = "DELETE FROM COMM WHERE commID = ? and bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commID);
            pstmt.setInt(2, bbsID);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("commDelete SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }

    public Comm getComm(int commID, int bbsID) {
        String SQL = "SELECT * FROM COMM WHERE commID = ? and bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commID);
            pstmt.setInt(2, bbsID);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Comm comm = new Comm();
                comm.setCommID(rs.getInt(1));
                comm.setUserID(rs.getString(2));
                comm.setCommDate(rs.getString(3));
                comm.setCommContent(rs.getString(4));
                comm.setBbsID(rs.getInt(5));
                return comm;
            }
        } catch(SQLException e) {
            System.err.println("getBbs SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return null;
    }

}
