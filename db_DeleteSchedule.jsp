<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    Connection conn=null; 
    PreparedStatement pstmt = null;
    int rsInt = 0;
    request.setCharacterEncoding("utf-8");

    String id = (String) session.getAttribute("sessionId");
    int index = Integer.parseInt(request.getParameter("deleteIdx"));
    String isPushDeleteBtn = (String) request.getParameter("isPushDeleteBtn");

    if(isPushDeleteBtn.equals("false")) return;
    if(id != null){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","stageus", "1234");
            String sql = "delete from schedule where id=? and idx=?";
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, id);
            pstmt.setInt(2, index);
            rsInt = pstmt.executeUpdate();
            int count = rsInt;

            if(count == 0){
                request.setAttribute("isDeleteSuccess", "false");
            }
            else{
                request.setAttribute("isDeleteSuccess", "true");
            }
        }
        finally{
            if(pstmt != null){
                try{
                    pstmt.close();
                }
                catch(Exception e){}
            }
            if(conn != null){
                try{
                    conn.close();
                }
                catch(Exception e){}
            }
        }
    }
    else{
        out.println("<script> alert(\"세션이 만료되었습니다 다시 로그인 해주세요\"); </script>");
        out.println("<script> location.href = \"./Login.jsp\"; </script>");
    }
%>