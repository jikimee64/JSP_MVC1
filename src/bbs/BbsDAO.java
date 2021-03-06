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

    public int write(String bbsTitle, String userID, String bbsContent, String fileName) {
        String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?,?,0)";
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
            pstmt.setString(6, fileName);
            pstmt.setInt(7, 1);
            return pstmt.executeUpdate();
        } catch(SQLException e) {
            System.err.println("write SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {System.err.println("Login SQLException error");}
        }
        return -1;
    }

    public ArrayList<Bbs> getList( String search, int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 and " +
                "CONCAT(bbsTitle, bbsContent) LIKE ? " +
                "ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setFileName(rs.getString(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setLikeCount(rs.getInt(8));
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
                bbs.setFileName(rs.getString(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setLikeCount(rs.getInt(8));
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

    public int update(int bbsID, String bbsTitle, String bbsContent, String fileName) {
        String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ?, fileName = ? WHERE bbsID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setString(3, fileName);
            pstmt.setInt(4, bbsID);
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


    public int like(String bbsID) {
        String SQL = "UPDATE BBS SET likeCount = likeCount + 1 WHERE bbsID = ? ";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL); //데이터를 실제로 넣어줄 수 있는 역할
            pstmt.setInt(1, Integer.parseInt(bbsID));
            return pstmt.executeUpdate();
        }catch (Exception e) {
            System.err.println("like SQLException error");
        } finally {
            if(conn != null) try {conn.close();} catch (SQLException e) {e.printStackTrace();}
            if(pstmt != null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
            if(rs != null) try {rs.close();} catch (SQLException e) {e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }





}
