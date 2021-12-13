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
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>    
        <script type="text/javascript">
      

      var p;
      var p2;
      $.ajax({
        	url:'graph',
        	success:function(data1){
        
            p=data1;
            google.charts.load('current', {'packages':['bar']});
            google.charts.setOnLoadCallback(drawChart);
        	}
        
        });
      $.ajax({
        	url:'graph2',
        	success:function(data2){
        		// debugger;
            console.log("ajax"+data2);
            p2=data2;
            google.charts.load("current", {packages:["corechart"]});  
            google.charts.setOnLoadCallback(drawpiechart);
        	}
        
        });
      //bar chart
      function drawChart() {
       //console.log(p); 
       const t=p.slice(1,-1).split(", ");
       //
      //  debugger;
     
       
        var data = google.visualization.arrayToDataTable([
          ['Year', 'Income', 'Expenses', 'Savings'],
          [t[0], parseInt(t[1]), parseInt(t[2]),parseInt(t[3])],
          [t[4], parseInt(t[5]), parseInt(t[6]),parseInt(t[7])],
          [t[8], parseInt(t[9]), parseInt(t[10]),parseInt(t[11])],
          [t[12], parseInt(t[13]), parseInt(t[14]),parseInt(t[15])],
        ]);

        var options = {
          chart: {
            title: 'Report',
            subtitle: 'Income, Expenses, and Saving',
          }
        };
        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }


      //piechart
     
      function drawpiechart() {
        const pe=p2.slice(1,-1).split(", ");
       var a,b,c;
       console.log(pe);
       if(pe.length==0)
      { a=1;
        b=1;
        c=1;}
        else if(pe.length==1)
        { a=parseInt(pe[1]);
          b=0;
          c=0;}
          else if(pe.length==2)
        { a=parseInt(pe[1]);
          b=parseInt(pe[3]);
          c=0;}
          else 
        { a=parseInt(pe[1]);
          b=parseInt(pe[3])
          c=parseInt(pe[5]);}
      //  debugger;
        var piedata = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['cash',     a],
          ['card',      b],
          ['Bitcoin',  c],
         
        ]);

        var pieoptions = {
          title: 'Payment methods',
          is3D: true,
        };

        var Piechart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        Piechart .draw(piedata, pieoptions);
      }
        </script>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
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
            </div>Current Budget</a>
            <a style=" color: #696969;cursor:pointer;" data-toggle="modal" data-target="#reportmodal"><div class="spinner-grow text-warning" role="status">
            </div>Report</a>
        
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
        <div style="text-align: right;">
            <button type="button" class="btn-xl rounded-pill btn-success btn-primary" data-toggle="modal" data-target="#incomemodal">
                + Income </button> 
            <button type="button" class="btn-xl rounded-pill btn-danger btn-primary" data-toggle="modal" data-target="#expencemodal">
                - Expense </button> 
        </div>
        <br>
        <%
        int amt=0;
        int exp=0;
        String cat=null;
        String mname[]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        int m=0;
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
          String t="select sum(Amount) as amount from income where month(date)="+month+" and year(date)="+year+" and User_id= "+session.getAttribute("ID");
          String t2="select sum(Amount) as amount from expense where month(date)="+month+" and year(date)="+year+" and User_id= "+session.getAttribute("ID");
          String t3="SELECT bcategory.Name, SUM(expense.amount) as tot FROM expense left join bcategory on expense.Category_id=bcategory.Category_id  where month(expense.date)= "+month+" and expense.User_id= "+session.getAttribute("ID")+" GROUP BY expense.Category_id order by tot desc" ;
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(url,sname,spass);
          PreparedStatement st=con.prepareStatement(t);
          PreparedStatement st2=con.prepareStatement(t2); 
          PreparedStatement st3=con.prepareStatement(t3); 

          ResultSet rs=st.executeQuery();
          ResultSet rs2=st2.executeQuery();
          ResultSet rs3=st3.executeQuery();

          if(rs.next())
			    amt=rs.getInt("amount");
          if(rs2.next())
			    exp=rs2.getInt("amount");
          if(rs3.next())
            cat=rs3.getString("Name");
			
        } catch (Exception e) {
          System.out.println(e);
          }
        
        %>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                       
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body"><%=mname[m]%>-Income</div>
                                   
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#"><%=amt%></a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body"><%=mname[m]%>-Expense</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#"><%=exp%></a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body"><%=mname[m]%>-Saving</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#"><%=amt-exp%></a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body"><%=mname[m]%>-High Spending Category</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#"><%=cat%></a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                      <i class="fas fa-chart-bar me-1"></i>
                                        Bar Chart
                                    </div>
                                    <div class="card-body">  <div  id="columnchart_material" style="width: 500px; height: 315px;"></div></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        Pie Chart 
                                    </div>
                                    <div class="card-body"> <div  id="piechart_3d" style="width: 500px; height: 315px;"></div></div>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Your Expenses
                            </div>
                            
                            <div class="card-body">
                                <table class="table">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Date</th>
                                            <th>Amount</th>
                                            <th>Category</th>
                                        </tr>
                                    </thead>
                                    <%
                                    RelationalAPI relapi = RelationalAPI.getInstance();
                                    java.sql.Connection con = null;
                                    con = relapi.getConnection();
                                    String tableName="expense";
                                    try {
                                        Table table = new Table(tableName);
                                        SelectQueryImpl selectQueryImpl = new SelectQueryImpl(table);
                                        Join join1 =new Join(tableName, "bcategory", new String[]{"Category_id"}, new String[]{"Category_id"}, Join.LEFT_JOIN);
                                        Criteria ci1=new Criteria(new Column(tableName,"User_id"),session.getAttribute("ID"),0);
                                       
                                        Column column1 = new Column(tableName, "*");
                                        Column column2 = new Column("bcategory", "*");
                                        selectQueryImpl.addJoin(join1);
                                        selectQueryImpl.addSelectColumn(column1);
                                        selectQueryImpl.addSelectColumn(column2);
                                        Persistence per = (Persistence)BeanUtil.lookup("Persistence");

                                        selectQueryImpl.setCriteria(ci1);
                                        DataSet d = relapi.executeQuery(selectQueryImpl,con); 
                                        PrintWriter out1=response.getWriter();
                                    
                                        while(d.next())
                                        {   
                                    %>
                                    <tbody>
                                        <tr>
                                            
                                            <td><%=d.getValue("Date")%></td>
                                            <td><%=d.getValue("Amount")%></td>
                                            <td><%=d.getValue("Name")%></td>
                                       
                                        </tr>
                                        
                                        <%
                                    }
                                    d.close();

                                        } catch (Exception e) {
                                        // TODO Auto-generated catch block
                                        e.printStackTrace();
                                    }                                    
                                    %>
                                    </tbody>
                                  
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
           
            </div>
        </div>
    
       
        
      
      
   <!-- Expence Modal -->
     <div class="modal fade" id="expencemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Adding Expence</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
                <div class="user" >
                    <form action="AddExpense" method="post">
                    
                       <div class="form-group">
                        <label for="exampleFormControlInput1">Amount</label>
                        <input type="number" class="form-control" id="exampleFormControlInput1" name="PAmt" placeholder="Amount" required>
                      </div>
                      
                      <label for="cars">Choose a Expence Category:</label>
                      <select id="cate" name="PECategory" required>
                        <%
                       
                        String tableNamem1="bcategory";
                        try {
                            Table tablem1 = new Table(tableNamem1);
                            SelectQueryImpl selectQueryImplm1 = new SelectQueryImpl(tablem1);
                           
                            Column columnm1 = new Column(tableNamem1, "*");
                            Criteria cc1=new Criteria(new Column(tableNamem1,"User_id"),session.getAttribute("ID"),0);
                            selectQueryImplm1.setCriteria(cc1);
                            selectQueryImplm1.addSelectColumn(columnm1);
                            DataSet dm1 = relapi.executeQuery(selectQueryImplm1,con); 
                            while(dm1.next())
                            {
                              %>
                        <option value=<%=dm1.getValue("Category_id")%>><%=dm1.getValue("Name")%></option>
                       <%}
                       dm1.close();
                      } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }                         %>
                    
                      </select>
                      <button onclick="location.href = 'Addbcat.jsp';"><i class="glyphicon glyphicon-plus-sign" style="font-size:20px"></i>+ Add category</button></p>
                        <div class="form-group">
                          <label for="cars">Choose Date of spending:</label>
                        <input type="date" id="date" name="PDate" required>
                         </div>
                         <label for="cars">Choose a Type of Payment:</label>
                      <select id="cate" name="PCategory" required>
                        <%
                       
                        String tableName1="Payment_method";
                        try {
                            Table table1 = new Table(tableName1);
                            SelectQueryImpl selectQueryImpl1 = new SelectQueryImpl(table1);
                            Column column11 = new Column(tableName1, "*");
                            selectQueryImpl1.addSelectColumn(column11);
                            DataSet d1 = relapi.executeQuery(selectQueryImpl1,con); 
                            PrintWriter out1=response.getWriter();
                            while(d1.next())
                            {
                              %>
                        <option value=<%=d1.getValue("Paymentmethod_id")%>><%=d1.getValue("Name")%></option>
                       <%}
                       d1.close();
                      
                      } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }                         %>
                    
                      </select>
                      
                      <div class="form-group">
                        <label for="exampleFormControlTextarea1">Comments</label>
                        <textarea class="form-control" id="exampleFormControlTextarea1" name="PComm" rows="3" required></textarea>
                      </div>
                      
                     
                      <div class="form-group">
                        <!-- <input type='hidden' value='0' name='Recur'> -->
                        <input type="checkbox" name="Recur" value="1">
                        <label for="recur"> Recurring Expence</label><br>
                      </div>
                    
                    </div>
            </div>

            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            </div>
          </div>
        </div>
      </div>

       <!--Income Modal -->
       <div class="modal fade" id="incomemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Adding Income</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="user" >
                <form action="AddIncome" method="post">
                
                   <div class="form-group">
                    <label for="exampleFormControlInput1">Amount</label>
                    <input type="number" class="form-control" id="exampleFormControlInput1" name="PAmt" placeholder="Amount" required>
                  </div>
                  
                  <label for="cars">Choose a Category:</label>
                  <select id="cate" name="PCategory" required>
                    <%
                    
                    String tableNamem21="Income_type";
                    try {
                        Table tablem21 = new Table(tableNamem21);
                        SelectQueryImpl selectQueryImplm21 = new SelectQueryImpl(tablem21);
                        Criteria c21 =new Criteria(new Column(tableNamem21,"User_id"),session.getAttribute("ID"),0);
                        Column columnm21 = new Column(tableNamem21, "*");
                        selectQueryImplm21.addSelectColumn(columnm21);
                        selectQueryImplm21.setCriteria(c21);
                        DataSet dm21 = relapi.executeQuery(selectQueryImplm21,con); 
                        while(dm21.next())
                        {
                          %>
                    <option value=<%=dm21.getValue("Incometype_id")%>><%=dm21.getValue("Source")%></option>
                   <%}
                   con.close();
                  } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }                         %>
                
                  </select>
                  <button onclick="location.href = 'Additype.jsp'"><i class="glyphicon glyphicon-plus-sign" style="font-size:20px"></i>+ Add category</button>
                    <div class="form-group">
                      <label for="cars">Choose the Date of income:</label>
                    <input type="date" id="date" name="PDate" required>
                     </div>
                  <div class="form-group">
                    <label for="exampleFormControlTextarea1">Comments</label>
                    <textarea class="form-control" id="exampleFormControlTextarea1" name="PComm" rows="3" required></textarea>
                  </div>
                   
              
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            </div>
          </div>
        </div>
      </div>



       <!--report Modal -->
       <div class="modal fade" id="reportmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Adding Income</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="row">
                <div class="col">
                  <p style=" font-family: 'Stylish';font-size: 22px;">Monthly Report</p>
                  <form action="Report.jsp">
                    <%
                    GregorianCalendar date = new GregorianCalendar();      
                    int month = date.get(Calendar.MONTH);
                    int year=date.get(Calendar.YEAR);
                    month = month+1;
                    String mm=year+"-"+month;
                    %>
                    <input type="month" id="date" name="date" max=<%=mm%> value=<%=mm%>>
                    <input type="hidden" value=1 name="type" >
                    <br>
                    <button type="submit" >Generate Report</button>
                  </form>
                </div>
                <div style="text-align: center;" class="col">
                  <p style=" font-family: 'Stylish';font-size: 22px;">Yearly Report</p>

                  <form action="Report.jsp">
                    <input type="int" name="date" >
                    <input type="hidden" value=2 name="type" >
                    <br>
                      <button type="submit" >Generate Report</button>
                    </form>
                </div>
                </div>
            </div>
          </form>

           
          </div>
        </div>
      </div>
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
