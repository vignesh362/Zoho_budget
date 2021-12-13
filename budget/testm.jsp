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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>    
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="home.css">    
     
       
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
            </div>graphs</a>
            
        
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
          <br>
          <table class="table">
            <thead class="thead-dark">
              <tr>
                <th scope="col">Category</th>
                <th scope="col">Budget</th>
                <th scope="col">Expense</th>
              </tr>
            </thead>
            <tbody>
    <%
        int bud=0;
        int exp=0;
        String mname[]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        int m=0;
        ArrayList<String> budget=new ArrayList<String>();
        ArrayList<String> expense=new ArrayList<String>();
        ArrayList<String> cat=new ArrayList<String>();
          try{   
          int month;
          GregorianCalendar date = new GregorianCalendar();      
          month = date.get(Calendar.MONTH);
          int year=date.get(Calendar.YEAR);
          m=month;
          month = month+1;
          String url="jdbc:mysql://localhost:3306/complaint";
          String sname="root";
          String spass="";
          String qu="select * from bcategory where User_id="+session.getAttribute("ID");
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(url,sname,spass);
          PreparedStatement stmt=con.prepareStatement(qu);
          System.out.println(qu);
    
          ResultSet rr=stmt.executeQuery();     
        while(rr.next()){
          System.out.println("inside");
    
          String t="select * from category_budget left join budget on category_budget.Budget_id=budget.Budget_id where User_id="+session.getAttribute("ID")+" and Category_id="+rr.getInt("Category_id")+" order by created_on desc";
          String t2="select sum(Amount) as amount from expense where month(date)="+month+" and year(date)="+year+" and User_id="+session.getAttribute("ID")+" and Category_id="+rr.getInt("Category_id");
         
          PreparedStatement st=con.prepareStatement(t);
          PreparedStatement st2=con.prepareStatement(t2); 
          System.out.println(t);
          System.out.println(t2);
          ResultSet rs=st.executeQuery();
          ResultSet rs2=st2.executeQuery();
    
          if(rs.next())
                  bud=rs.getInt("amount");
          if(rs2.next())
                  exp=rs2.getInt("amount");
        %>
         
        
        <tr>
            <td><%=rr.getString("name")%></td>
            <td><%=Integer.toString(bud)%></td>
            <td><%=Integer.toString(exp)%></td>
          </tr>
         
         
          <% }
          System.out.println(cat);
           System.out.println(budget);
           System.out.println(expense);
    
        }catch(Exception e)
        {
            System.out.println(e);
        }
    
    %>
    
         
          
        </tbody>
      </table>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
      <script src="js/datatables-simple-demo.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
     
    </body>
</html>
