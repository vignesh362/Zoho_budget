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
    
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="home.css">    
        <link href="css/styles.css" rel="stylesheet" />
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
          <br>
          
                <div class="card text-center">
                    <div class="card-header">
                      Income Categories
                    </div>
                    <div class="card-body">
                      <h5 class="card-title">Special title treatment</h5>
                      <div class="user" >
                        <form action="Addcat" method="post">
                          <input type="hidden" id="cat1" name="custId" value="1">
                           <div class="form-group">
                            <label for="exampleFormControlInput1">Name</label>
                            <input type="text" class="form-control"  name="name" placeholder="Name" required>
                          </div>
                          <div class="form-group">
                            <label for="exampleFormControlTextarea1">Comments</label>
                            <textarea class="form-control" name="comm" rows="3" required></textarea>
                          </div>
                          <button type="submit" class="btn btn-primary">ADD</button>

                        </div>
                    </div>
                   
                  </div>
               
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
      <script src="js/scripts.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
      <script src="js/datatables-simple-demo.js"></script>
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
     
    </body>
</html>
