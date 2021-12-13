import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import java.sql.*;
import com.adventnet.persistence.*;
import java.io.PrintWriter;
import com.adventnet.db.api.RelationalAPI;
import java.util.Iterator;
import java.util.*;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime; 

public class AddExpense extends HttpServlet {
	
private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("Text/html");
		String a=(String)request.getParameter("PAmt");
		String b=request.getParameter("PECategory");
		String c=request.getParameter("PDate");
        String d=request.getParameter("PCategory");
		String e=request.getParameter("PComm");
		String f=request.getParameter("Recur");
		if (f == null)
			f="0";
		
		System.out.println(f+"recur input");
		HttpSession session=request.getSession();
		//int e=Integer.parseInt(session.getAttribute("ID"));
		//System.out.println(a+b+c+d);
		String tbname = "expense";	
		Connection conn = null;
		DataSet ds = null;
		
		try
		{
			//Add data in table
			Persistence per= (Persistence)BeanUtil.lookup("Persistence");
			Row row = new Row(tbname);
			row.set("Amount",a);
			row.set("Paymentmethod_id",d);
			row.set("Comments",e);
            row.set("Date",c);
            row.set("Category_id",b);
			row.set("User_id",session.getAttribute("ID"));
			DataObject data = new WritableDataObject();
			data.addRow(row);
			per.add(data);
			int bud=0,exp=0;
			if(f.equals("1"))
			{  	System.out.println("inside checkbox");  

				Row row1 = new Row("recurr_exp");
				row1.set("Amount",a);
				row1.set("Comments",e);
				row1.set("Date",c);
				row1.set("Category_id",b);
				row1.set("User_id",session.getAttribute("ID"));
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
				LocalDateTime now = LocalDateTime.now();  
				System.out.println(dtf.format(now)+"inside checkbox");  
				row1.set("Created_on",dtf.format(now));
				DataObject data1 = new WritableDataObject();
				data1.addRow(row1);
				per.add(data1);
			}
			Calendar calendar = Calendar.getInstance();  
			int year= calendar.get(Calendar.YEAR);  
			int date= calendar.get(Calendar.DATE); 
			int month= calendar.get(Calendar.MONTH); 
	
			month = month+1;
			String url="jdbc:mysql://localhost:3306/complaint";
			String sname="root";
			String spass="";
			String t="select * from category_budget left join budget on category_budget.Budget_id=budget.Budget_id where User_id="+session.getAttribute("ID")+" and Category_id="+b+" order by created_on desc;";
			String t2="select sum(Amount) as amount from expense where month(date)="+month+" and year(date)="+year+" and User_id="+session.getAttribute("ID")+" and Category_id="+b;
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection(url,sname,spass);
			PreparedStatement st=con.prepareStatement(t);
			PreparedStatement st2=con.prepareStatement(t2); 
  
			ResultSet rs=st.executeQuery();
			ResultSet rs2=st2.executeQuery();
  
			if(rs.next())
				  bud=rs.getInt("amount");
			if(rs2.next())
				  exp=rs2.getInt("amount");
			// System.out.println(bud);
			// System.out.println(exp);
			if(bud<exp & bud!=0)
			{	System.out.println("overspending");
			response.sendRedirect("overspending.html");			}
			else{
				response.sendRedirect("homepage.jsp");			}

			
			con.close();
			
			
		}
		catch(Exception e1)
	        {
			e1.printStackTrace();
			response.getWriter().println("<meta http-equiv='refresh' content='0;URL=homepage.jsp'>");
			response.getWriter().println("<script>  alert(\"Error !\");</script>");
		}
	
		
			
	
	
	}
	}

	

