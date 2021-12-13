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

public class AddIncome extends HttpServlet {
	
private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("Text/html");
		String a=(String)request.getParameter("PAmt");
		String b=request.getParameter("PCategory");
		String c=request.getParameter("PDate");
		String d=request.getParameter("PComm");
		HttpSession session=request.getSession();
		//int e=Integer.parseInt(session.getAttribute("ID"));
		System.out.println(a+b+c+d);
		String tbname = "Income";	
		Connection conn = null;
		DataSet ds = null;
		
		try
		{
			//Add data in table
			Persistence per= (Persistence)BeanUtil.lookup("Persistence");
			Row row = new Row(tbname);
			row.set("Amount",a);
			row.set("Date",c);
			row.set("Comments",d);
			row.set("User_id",session.getAttribute("ID"));
			row.set("Incometype_id",b);
			DataObject data = new WritableDataObject();
			data.addRow(row);
			per.add(data);
			response.sendRedirect("homepage.jsp");
			// response.getWriter().println("<meta http-equiv='refresh' content='0;URL=homepage.jsp'>");
			// response.getWriter().println("<script>  alert(\"Successfully Added !\");</script>");
		}
		catch(Exception e1)
	        {
			e1.printStackTrace();
			response.getWriter().println("<meta http-equiv='refresh' content='0;URL=homepage.jsp'>");
			response.getWriter().println("<script>  alert(\"Error !\");</script>");
		}
	
		
			
	
	
	}
	}

	

