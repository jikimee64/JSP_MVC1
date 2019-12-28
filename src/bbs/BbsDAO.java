package bbs;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO {

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
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
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

    public int write(String bbsTitle, String userID, String bbsContent) {
        String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("write SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }

    public ArrayList<Bbs> getList(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                list.add(bbs);
            }
        } catch(SQLException e) {
            System.err.println("getList SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return list;
    }

    public boolean nextPage(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                return true;
            }
        } catch(SQLException e) {
            System.err.println("nextPage SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return false;
    }

    public Bbs getBbs(int bbsID) {
        String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                return bbs;
            }
        } catch(SQLException e) {
            System.err.println("getBbs SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return null;
    }

    public int update(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setInt(3, bbsID);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("Update SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }

    public int delete(int bbsID) {
        String SQL = "DELETE FROM BBS WHERE bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("Delete SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }




}
