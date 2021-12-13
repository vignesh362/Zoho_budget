<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.IOException,
    javax.servlet.*,
    javax.servlet.http.*,
    com.adventnet.ds.query.*,
    com.adventnet.ds.query.SelectQueryImpl,
    com.adventnet.mfw.bean.BeanUtil,
    java.sql.*,
    com.adventnet.persistence.*,
    java.io.PrintWriter,
    com.adventnet.db.api.RelationalAPI,

    java.util.*" 
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Budget your life!</title>
       
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="home.css">    
      <style>
        @media print {
          #printPageButton {
            display: none;
          }
        }
      </style>
       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body id="main">
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
            if(session.getAttribute("ID")==null)
            {
                response.sendRedirect("index.html");
            }
         %>
         <div id="mySidenav" class="sidenav">
          <a style=" color: #f1f1f1;cursor:pointer;" class="closebtn" onclick="closeNav()">&times;</a>
     
          <a href="homepage.jsp"><div class="spinner-grow text-danger" role="status">
          </div>Home</a>
          <a href="Budget.jsp"><div class="spinner-grow text-success" role="status">
          </div>Budget</a>
          <a href="testm.jsp"><div class="spinner-grow text-primary" role="status">
          </div>Current Budget</a>
          
      
        </div>
        
          
        <nav class="navbar navbar-light bg-light">
            <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; </span>
            <a class="navbar-brand" href="homepage.jsp">
              <img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/ZOHO.svg" width="30" height="30" class="d-inline-block align-top" alt="">
              
          BUDGET
            </a>
          
            <form class="form-inline my-2 my-lg-0" action="logout" method="post">
              <button class="btn btn-outline-success my-2 my-sm-0"  type="submit">Logout</button>
            </form>

          </nav>

          <button id="printPageButton" onclick="window.print()">Print report</button>
          <p style=" font-family: 'Stylish';font-size: 22px;">Expence Table</p>
          <table class="table">
            <thead class="thead-dark">
              <tr>
                <th scope="col">Date</th>
                <th scope="col">Amount</th>
                <th scope="col">Payment</th>
                <th scope="col">Category</th>
                <th scope="col">Comments</th>
              </tr>
            </thead>
            <tbody>
         <%
             
        String mname[]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        String d=request.getParameter("date");
        String type=request.getParameter("type");
        String[] arr=new String[2];
        if(type.equals("1")){
          arr = d.split("-");
        }
       
        int total=0,itotal=0;
        String t,t2;
        try{   
         
          String url="jdbc:mysql://localhost:3306/complaint";
          String sname="root";
          String spass="";
            if(type.equals("1")){
              t="select date,amount,payment_method.name as paymethod,bcategory.name as category,expense.comments from ((expense left join bcategory on expense.category_id =bcategory.category_id) inner join payment_method on expense.Paymentmethod_id=payment_method.Paymentmethod_id) where expense.User_id="+session.getAttribute("ID")+" and month(date)="+arr[1]+" and year(date)="+arr[0]+" order by date";
              t2="select Date,Amount,source,income.comments from income left join income_type on income.incometype_id=income_type.incometype_id where income.User_id="+session.getAttribute("ID")+" and month(date)="+arr[1]+" and year(date)="+arr[0]+" order by date";
            }
            else{
             t="select date,amount,payment_method.name as paymethod,bcategory.name as category,expense.comments from ((expense left join bcategory on expense.category_id =bcategory.category_id) inner join payment_method on expense.Paymentmethod_id=payment_method.Paymentmethod_id) where expense.User_id="+session.getAttribute("ID")+" and year(date)="+d+" order by date" ;
             t2="select Date,Amount,source,income.comments from income left join income_type on income.incometype_id=income_type.incometype_id where income.User_id="+session.getAttribute("ID")+" and year(date)="+d+" order by date";

            }
          
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(url,sname,spass);
          PreparedStatement st=con.prepareStatement(t);
          PreparedStatement st2=con.prepareStatement(t2);
         // System.out.println(t);
         // System.out.println(t2);
          ResultSet rs=st.executeQuery();
          ResultSet rs2=st2.executeQuery();
 
          while(rs.next())
	        {  	total=total+rs.getInt("amount");%>
           
                <tr class="table-danger">
                  <td><%=rs.getDate("date")%></td>
                  <td><%=rs.getInt("amount")%></td>
                  <td><%=rs.getString("paymethod")%></td>
                  <td><%=rs.getString("category")%></td>
                  <td><%=rs.getString("comments")%></td>
                </tr>
                
                        
                   <% }%>
                  
                </tbody>
              </table>
              <p style=" font-family: 'Stylish';font-size: 22px;">Income Table</p>
                   <table class="table">
                    <thead class="thead-dark">
                      <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Amount</th>
                        <th scope="col">source</th>
                        <th scope="col">Comments</th>
                      </tr>
                    </thead>
                    <tbody>
        <%       
            while(rs2.next())
              {  	itotal=itotal+rs2.getInt("amount");   %>
              
              <tr class="table-success">
                <td><%=rs2.getDate("date")%></td>
                <td><%=rs2.getInt("amount")%></td>
                <td><%=rs2.getString("source")%></td>
                <td><%=rs2.getString("comments")%></td>
              </tr>         
    <%  }%>
            </tbody>
          </table> 
             
      <%  } catch (Exception e) {
          System.out.println(e);
      }
         %>
         
      <p style=" font-family: 'Stylish';font-size: 22px;"> Total Income: <%=itotal%> </p>
      <p style=" font-family: 'Stylish';font-size: 22px;"> Total spent: <%=total%></p>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
      <script src="js/datatables-simple-demo.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
      <script>
        
        function openNav() {
                 document.getElementById("mySidenav").style.width = "250px";
                 document.getElementById("main").style.marginLeft = "250px";
                 }
 
         function closeNav() {
                 document.getElementById("mySidenav").style.width = "0";
                 document.getElementById("main").style.marginLeft= "0";
                 }
           
         </script>
    </body>
</html>
