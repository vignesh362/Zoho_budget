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
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="home.css">    
        <link href="css/styles.css" rel="stylesheet" />
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
              <button class="btn btn-outline-success my-2 my-sm-0"  type="submit">LogOut</button>
            </form>

          </nav>
          <br>
       
          <form onsubmit="getparams()">
            <table id="tbl" class="table table-striped">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th style="display:none;" scope="col">c_id</th>

                  <th scope="col">Name</th>
                  <th scope="col">Value</th>
                  
                </tr>
              </thead>
              <tbody>
                
            <%
            int k=1;
            RelationalAPI relapi = RelationalAPI.getInstance();
            java.sql.Connection con = null;
            con = relapi.getConnection();
            String tableName="bcategory";
            try {
                Table table = new Table(tableName);
                SelectQueryImpl selectQueryImpl = new SelectQueryImpl(table);
                Criteria ci1=new Criteria(new Column(tableName,"User_id"),session.getAttribute("ID"),0);
               
                Column column1 = new Column(tableName, "*");
                selectQueryImpl.addSelectColumn(column1);
                Persistence per = (Persistence)BeanUtil.lookup("Persistence");

                selectQueryImpl.setCriteria(ci1);
                DataSet d = relapi.executeQuery(selectQueryImpl,con); 
                PrintWriter out1=response.getWriter();
                while(d.next())
                { 

                  %>
                 
                      <tr>
                        <td scope="row"><%=k%></td>
                       
                        <td style="display:none;"><%=d.getValue("Category_id")%> </td>
                        <td><%=d.getValue("Name")%></td>

                        <td><input type="number" class="form-control" name="<%=d.getValue("Category_id")%>" placeholder="Amount" required>
                        </td>
                       
                      </tr>
                      
                    
<%
          ++k;
        }
            } catch (Exception e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
                   }  %>
                  </tbody>
                </table>
            <button type="submit" class="btn btn-primary">Submit</button>

          </form>


        
          <script>
        
            function openNav() {
                     document.getElementById("mySidenav").style.width = "250px";
                     document.getElementById("main").style.marginLeft = "250px";
                     }
     
             function closeNav() {
                     document.getElementById("mySidenav").style.width = "0";
                     document.getElementById("main").style.marginLeft= "0";
                     }

             function getparams(){
              var table = document.getElementById("tbl");
              var rows= table.rows;

              var json_obj,json_arr=[],json_filter;
              for(i=1;i<rows.length;i++)
              {           
                    json_obj = { "id":rows[i].cells[1].innerText, "value":rows[i].cells[3].getElementsByTagName("input")[0].value };
                    json_arr.push(json_obj);
              }
              json_filter=JSON.stringify(json_arr);
              console.log(json_filter);
              //alert(json_filter);
              $.post("AddBudget",{x:json_filter});
             }
             
             </script>
     
    </body>
</html>
